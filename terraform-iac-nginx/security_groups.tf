# Define security group for EC2 instances
resource "aws_security_group" "instance_sg" {
  name        = var.instance_security_group_name
  description = "Enhanced Security group for EC2 Instances"
  vpc_id      = aws_vpc.project_vpc.id

  # Ingress rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr] # Allow SSH access from specific CIDR block
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_http_cidr] # Allow HTTP access from specific CIDR block
  }

  # Egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Enable logging
  lifecycle {
    ignore_changes = [ingress, egress] # Ignore changes to ingress and egress rules
  }

  # Tags for better organization
  tags = {
    Name = var.instance_security_group_name
  }
}

