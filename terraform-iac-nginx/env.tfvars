# AWS Region
aws_region = "ap-southeast-1"

# Subnet CIDR blocks for current default VPC CIDR which wont overlap with other existing subnets.
subnet_cidr = ["172.31.66.0/24", "172.31.82.0/24"]

# Availability Zones
availability_zones = ["ap-southeast-1a", "ap-southeast-1b"]

# Application Load Balancer
alb_name = "project-alb-name"
alb_security_group_name = "proj-alb-sg1"

# EC2 Instance
instance_type = "t2.micro"
instance_security_group_name = "project-sg"
http_server_port = 80
ssh_port = 22

# SSH Key Name
ssh_key_name = "Shamik-key"

# Allowed CIDR blocks for SSH and HTTP access
allowed_ssh_cidr = "0.0.0.0/0"
allowed_http_cidr = "0.0.0.0/0"

# Prefix for resource names
prefix = "Shamik-proj"

# AMI Owner ID
ami_owner_id = "ubuntu"