provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "myweb" {
  ami = "1234"
  instance_type = "t3.micro"
}