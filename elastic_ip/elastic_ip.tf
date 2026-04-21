provider "aws" {
  region = "us-east-2"
}

##latest ubuntu for us-east-2
data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-*/ubuntu-noble-24.04-amd64-server-*"]
  }
}

#aws instance
resource "aws_instance" "web" {
  ami = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"
}

#static ip
resource "aws_eip" "lb" {
  instance = aws_instance.web.id
}