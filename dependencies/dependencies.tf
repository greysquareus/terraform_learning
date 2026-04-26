provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "my_sg" {}

resource "aws_instance" "web" {
  ami = ""
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
}

