resource "aws_internet_gateway" "proj-igw" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    Name = "proj-internet-gateway"
  }
}
