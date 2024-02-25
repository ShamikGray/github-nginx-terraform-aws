resource "aws_subnet" "public_subnet" {
  count             = length(var.availability_zones)
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = var.subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "Public_Subnet_${count.index + 1}"
  }
}

