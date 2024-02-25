# Generate SSH Key Pair for EC2 instances
resource "tls_private_key" "ec2_ssh_key" {
  algorithm = "ED25519"
}

# Upload Public Key to AWS
resource "aws_key_pair" "ec2_key_pair" {
  key_name   = local.private_key_filename
  public_key = tls_private_key.ec2_ssh_key.public_key_openssh
}

# EC2 instance
resource "aws_instance" "nginx_instance" {
  count                       = 2
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ec2_key_pair.key_name  # Using the SSH key pair generated
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnet[count.index].id
  availability_zone           = var.availability_zones[count.index]
  vpc_security_group_ids      = [aws_security_group.instance_sg.id]  # Specify the security group ID here

  tags = {
    Name    = "nginx-instance-${count.index}"
    Owner   = "Shamik"
    Project = "DevOpsTest"
  }
  
  volume_tags = {
    Name    = "nginx-instance-${count.index}"
    Owner   = "Shamik"
    Project = "DevOpsTest"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo yum -y update
    sudo yum -y install amazon-cloudwatch-agent
    # Additional setup commands go here
  EOF

  lifecycle {
    ignore_changes = [tags]  # Ignore changes to tags
  }
}

# Security Group
resource "aws_security_group" "instance_sg" {
  name = var.instance_security_group_name

  vpc_id = aws_vpc.project_vpc.id

  # Allow inbound HTTP requests and SSH
  ingress {
    from_port   = var.http_server_port
    to_port     = var.http_server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-sg-instance"
  }
}

# Create an SSM parameter for CloudWatch agent configuration
resource "aws_ssm_parameter" "cloudwatch_config" {
  name        = "/amazon-cloudwatch-agent/config.json"
  description = "CloudWatch agent configuration"
  type        = "String"
  value = jsonencode({
    logs = {
      logs_collected = {
        files = {
          collect_list = [{
            file_path        = "/var/log/messages"
            log_group_name   = "/var/log/messages"
            log_stream_name  = "{instance_id}"
          }]
        }
      }
    }
  })
}

resource "null_resource" "configure_web_app" {
  count     = length(aws_instance.nginx_instance)
  depends_on = [aws_eip_association.nginx_instance_public_ip]

  triggers = {
    build_number = timestamp()
  }

  provisioner "file" {
    source      = "files/"
    destination = "/home/ec2-user/"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.ec2_ssh_key.private_key_pem
      host        = aws_eip.nginx_instance_public_ip[count.index].public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y update",
      "sleep 15",
      "sudo yum -y install nginx",
      "sudo systemctl start nginx",
      "sudo chown -R ec2-user:ec2-user /var/www/html",
      "chmod +x *.sh",
      "./userdata.sh",
      "sudo cp nginx.conf /etc/nginx/nginx.conf",
      "sudo systemctl restart nginx",
      "sudo yum -y install python3-pip",
      "pip install flask",
      "nohup python3 app.py &",
      "sleep 15"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.ec2_ssh_key.private_key_pem
      host        = aws_eip.nginx_instance_public_ip[count.index].public_ip
    }
  }
}

resource "aws_eip_association" "nginx_instance_public_ip" {
  count        = length(aws_instance.nginx_instance)
  instance_id  = aws_instance.nginx_instance[count.index].id
  allocation_id = aws_eip.nginx_instance_public_ip[count.index].id
}

resource "aws_eip" "nginx_instance_public_ip" {
  count    = 2  # Adjust count based on the number of Elastic IPs required
  instance = aws_instance.nginx_instance[count.index].id
}
