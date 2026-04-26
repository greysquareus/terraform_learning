provider "aws" {
  region = "us-east-2"
}

locals {
  ports = ["20", "30", "40", "50", "60", "70", "80", "90", "100"]
}

variable "users" {
  type = set(string)
  default = [ "bob", "vasya", "petya", "user", "user", "admin" ]
}

variable "mymap" {
  default = {
      dev = "ami-123"
      prod = "ami-456"
  }
}

resource "aws_iam_user" "users" {
  for_each = var.users
  name = each.value
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "example" {
  security_group_id = aws_security_group.allow_tls.id
  for_each = toset(local.ports)
  cidr_ipv4   = "10.0.0.0/8"
  from_port   = tostring(each.value)
  ip_protocol = "tcp"
  to_port     = tostring(each.value)
}


resource "aws_instance" "webb" {
  for_each = var.mymap
  ami = each.value
  instance_type = "t2.micro"

  tags = {
    env = each.key
  }
}