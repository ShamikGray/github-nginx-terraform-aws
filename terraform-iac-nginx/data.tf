# Retrieve the latest Ubuntu AMI ID
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]  # Canonical
}

# Retrieve default VPC information
data "aws_vpc" "default" {
  default = true
}

# Retrieve default internet gateway information
data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
