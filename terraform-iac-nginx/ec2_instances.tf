# Define the private key for SSH
resource "tls_private_key" "ec2_ssh_key" {
  algorithm = "ED25519"
}

# Create an SSH key pair
resource "aws_key_pair" "ec2_key_pair" {
  key_name   = local.private_key_filename
  public_key = tls_private_key.ec2_ssh_key.public_key_openssh
}

# Launch EC2 instances
resource "aws_instance" "nginx_instance" {
  count                       = 2
  ami                         = data.aws_ami.ubuntu.id  # Use Ubuntu AMI
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ec2_key_pair.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnet[count.index].id
  availability_zone           = var.availability_zones[count.index]
  vpc_security_group_ids      = [aws_security_group.instance_sg.id, aws_security_group.project_alb_sg.id]

  tags = {
    Name    = "nginx-instance-${count.index}"
    Owner   = "Shamik"
    Project = "ProjectDevOps"
  }

  volume_tags = {
    Name    = "nginx-instance-${count.index}"
    Owner   = "Shamik"
    Project = "ProjectDevOps"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install -y amazon-cloudwatch-agent  # Install CloudWatch agent
    cat <<-EOF2 > /etc/awslogs/awslogs.conf
    [/var/log/app.log]
    datetime_format = %b %d %H:%M:%S
    file = /var/log/app.log
    buffer_duration = 5000
    log_stream_name = {instance_id}
    initial_position = start_of_file
    log_group_name = "/var/log/app.log"
    [/var/log/messages]
    datetime_format = %b %d %H:%M:%S
    file = /var/log/messages
    buffer_duration = 5000
    log_stream_name = {instance_id}
    initial_position = start_of_file
    log_group_name = "/var/log/messages"
    EOF2

    systemctl restart awslogsd
    systemctl enable awslogsd

    # Additional setup commands go here
  EOF

  lifecycle {
    ignore_changes = [tags]
  }
}

# Define security group for EC2 instances
resource "aws_security_group" "instance_sg" {
  name = var.instance_security_group_name

  vpc_id = data.aws_vpc.default.id

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

# Configure CloudWatch agent parameter
resource "aws_ssm_parameter" "cloudwatch_config" {
  name        = "/amazon-cloudwatch-agent/config.json"
  description = "CloudWatch agent configuration"
  type        = "String"
  value = jsonencode({
    logs = {
      logs_collected = {
        files = {
          collect_list = [{
            file_path        = "/var/log/app.log"
            log_group_name   = "/var/log/app.log"
            log_stream_name  = "{instance_id}"
          }, {
            file_path        = "/var/log/messages"
            log_group_name   = "/var/log/messages"
            log_stream_name  = "{instance_id}"
          }]
        }
      }
    }
  })
}

# Provision resources for configuring the web app
resource "null_resource" "configure_web_app" {
  count     = length(aws_instance.nginx_instance)
  depends_on = [aws_eip_association.nginx_instance_public_ip]

  triggers = {
    build_number = timestamp()
  }

  provisioner "file" {
    source      = "files/"
    destination = "/home/ubuntu/"  # Change destination user to ubuntu

    connection {
      type        = "ssh"
      user        = "ubuntu"  # Change user to ubuntu
      private_key = tls_private_key.ec2_ssh_key.private_key_pem
      host        = aws_eip.nginx_instance_public_ip[count.index].public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx",  # Install Nginx
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",  # Ensure Nginx starts on boot
      "sudo chown -R ubuntu:ubuntu /var/www/html",  # Change ownership to ubuntu user
      "chmod +x *.sh",
      "./userdata.sh",
      "sudo cp nginx.conf /etc/nginx/nginx.conf",
      "sudo systemctl restart nginx",
      "sudo apt install -y python3-pip",  # Install Python 3 and pip
      "pip install flask",
      "nohup python3 app.py &",
      "sleep 15"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.ec2_ssh_key.private_key_pem
      host        = aws_instance.nginx_instance[count.index].public_ip
    }
  }
}

# Associate Elastic IP with EC2 instances
resource "aws_eip_association" "nginx_instance_public_ip" {
  count        = length(aws_instance.nginx_instance)
  instance_id  = aws_instance.nginx_instance[count.index].id
  allocation_id = aws_eip.nginx_instance_public_ip[count.index].id
}

# Allocate Elastic IPs for EC2 instances
resource "aws_eip" "nginx_instance_public_ip" {
  count    = 2
  instance = aws_instance.nginx_instance[count.index].id
}
