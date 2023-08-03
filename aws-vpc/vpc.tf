provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "demo-vpc-ec2" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.micro"
  key_name               = "demo-ec2"
  vpc_security_group_ids = [aws_security_group.demo-vpc-ec2-sg.id]
  subnet_id              = aws_subnet.demo-vpc-public-subnet-01.id
}

resource "aws_security_group" "demo-vpc-ec2-sg" {
  name        = "demo-vpc-ec2-sg"
  description = "ssh access"
  vpc_id      = aws_vpc.demo-vpc.id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Instance_type = "Linux"
    Env           = "Dev",
    Name          = "demo-ec2"
  }
}


resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main"
  }
}

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
  availability_zone       = "us-east-1a"
  tags = {
    Name = "demo-vpc-public-subnet-02"
  }
}

resource "aws_internet_gateway" "demo-vpc-igw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name = "demo-vpc-igw"
  }
}

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

resource "aws_route_table_association" "demo-vpc-rta-subnet-01" {
  subnet_id      = aws_subnet.demo-vpc-public-subnet-01.id
  route_table_id = aws_route_table.demo-vpc-public-rt.id
}

resource "aws_route_table_association" "demo-vpc-rta-subnet-02" {
  subnet_id      = aws_subnet.demo-vpc-public-subnet-02.id
  route_table_id = aws_route_table.demo-vpc-public-rt.id
}

