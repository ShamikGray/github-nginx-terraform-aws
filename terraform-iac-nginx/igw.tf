resource "aws_internet_gateway" "proj-igw" {
  vpc_id = aws_vpc.project_vpc.id

  tags = {
    Name = "proj-internet-gateway"
  }
}
