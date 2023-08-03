
resource "aws_subnet" "demo-vpc-public-subnet-01" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "demo-vpc-public-subnet-01"
  }
}

resource "aws_subnet" "demo-vpc-public-subnet-02" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "demo-vpc-public-subnet-02"
  }
}
