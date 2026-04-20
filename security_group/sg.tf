provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
}


resource "aws_security_group" "ftp_acess" {
  name        = "ftp_allow"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  tags = {
    Name = "allow_ftp"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.ftp_acess.id
  cidr_ipv4         = aws_vpc.myvpc.cidr_block
  from_port         = 21
  ip_protocol       = "tcp"
  to_port           = 21
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.ftp_acess.id
  cidr_ipv6         = aws_vpc.myvpc.ipv6_cidr_block
  from_port         = 21
  ip_protocol       = "tcp"
  to_port           = 21
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.ftp_acess.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#Ipv6
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.ftp_acess.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}