provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "demo-ec2" {
  ami             = "ami-053b0d53c279acc90"
  instance_type   = "t2.micro"
  key_name        = "demo-ec2"
  security_groups = ["demo-ec2-sg"]
}

resource "aws_security_group" "demo-ec2-sg" {
  name        = "demo-ec2-sg"
  description = "ssh access"

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
