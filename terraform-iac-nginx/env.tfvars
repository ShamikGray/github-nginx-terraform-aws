# AWS Region
aws_region = "ap-southeast-1"

# Subnet CIDR blocks
subnet_cidr = ["10.1.0.0/24", "10.1.1.0/24"]

# Availability Zones
availability_zones = ["ap-southeast-1a", "ap-southeast-1b"]

# Application Load Balancer
alb_name = "project-alb"
alb_security_group_name = "project-alb-sg"

# EC2 Instance
instance_type = "t2.micro"
instance_security_group_name = "project-ec2-sg"
http_server_port = 80
ssh_port = 22

# SSH Key Name
ssh_key_name = "Shamik-key"

# Allowed CIDR blocks for SSH and HTTP access
allowed_ssh_cidr = "0.0.0.0/0"
allowed_http_cidr = "0.0.0.0/0"

# VPC CIDR Block
vpc_cidr = "10.1.0.0/16"

# AMI Owner ID
ami_owner_id = "amazon"

# Prefix for resource names
prefix = "Project-DevOps-Assignment"