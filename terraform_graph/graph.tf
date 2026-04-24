provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "mysg" {
  name        = "sec-group"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_eip" "static_ip" {
  instance = aws_instance.web
  domain = "vpc"
}

resource "aws_vpc_security_group_ingress_rule" "myrule" {
  security_group_id = aws_security_group.mysg.id

  cidr_ipv4 = "${aws_eip.lb.public_ip}/32"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
}

resource "aws_instance" "web" {
  ami = ""
  instance_type = "t2.micro"
  vpc_security_group_ids = aws_security_group.mysg.id

}