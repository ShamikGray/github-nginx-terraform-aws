#variable "vend_ip_api_url" {
#  description = "The URL of the REST API to retrieve the CIDR block"
#}

variable "aws_region" {
  description = "The AWS region where resources are deployed"
}

variable "subnet_cidr" {
  description = "Subnet CIDR range e.g 10.0.0.0/24, must be within VPC CIDR range"
}

variable "availability_zones" {
  description = "A list of availability zones within the selected region"
  type        = list(string)
}

variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
}

variable "alb_security_group_name" {
  description = "The name of the security group for the ALB"
  type        = string
}

variable "instance_type" {
  description = "Specifies the AWS instance type for EC2 instances"
}

variable "instance_security_group_name" {
  description = "The name of the security group for the EC2 Instances"
  type        = string
}

variable "http_server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
}

variable "ssh_key_name" {
  description = "The name of the SSH key pair to use for EC2 instances"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block to allow SSH access to EC2 instances"
}

variable "allowed_http_cidr" {
  description = "CIDR block to allow HTTP access to EC2 instances"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "ami_owner_id" {
  description = "The owner ID of the desired AMI"
}

variable "prefix" {
  description = "The prefix to be used for resource names"
  type        = string
}

variable "create_bucket" {
  type    = bool
  default = true  # Set the default value to true if you want to create the bucket by default
}
