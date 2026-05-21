provider "aws" {
  region = "us-east-1"  # change selon ta région de lab
}

resource "aws_security_group" "preprod_sg" {
  name = "preprod-sg-tf"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "preprod" {
  ami                    = "ami-0453ec754f44f9a4a"  # Amazon Linux 2023 us-east-1
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.preprod_sg.id]

  tags = {
    Name = "preprod-terraform"
  }
}

output "public_ip" {
  value = aws_instance.preprod.public_ip
}
