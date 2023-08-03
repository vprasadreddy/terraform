resource "aws_route_table_association" "demo-vpc-rta-subnet-01" {
  subnet_id      = aws_subnet.demo-vpc-public-subnet-01.id
  route_table_id = aws_route_table.demo-vpc-public-rt.id
}

resource "aws_route_table_association" "demo-vpc-rta-subnet-02" {
  subnet_id      = aws_subnet.demo-vpc-public-subnet-02.id
  route_table_id = aws_route_table.demo-vpc-public-rt.id
}
