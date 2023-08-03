resource "aws_route_table" "demo-vpc-public-rt" {
  vpc_id = aws_vpc.demo-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-vpc-igw.id

  }
  tags = {
    Name = "demo-vpc-public-rt"
  }
}
