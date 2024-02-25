# Retrieve the latest Amazon Linux 2 AMI ID
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-20.04-amd64-server-*"]
  }

  owners      = ["099720109477"]  # Canonical
}


data "aws_vpc" "default" {
  default = true
}

data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Retrieve the end IP address from the REST API
#data "external" "vend_ip" {
#  program = ["curl", var.vend_ip_api_url]
#}