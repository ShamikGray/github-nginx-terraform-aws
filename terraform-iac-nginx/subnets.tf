resource "aws_subnet" "public_subnet" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = element(var.subnet_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "Public_Subnet_${count.index + 1}"
  }
}
