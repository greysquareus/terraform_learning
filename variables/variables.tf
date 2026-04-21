provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "sg_database" {
  name        = "db_acess"
  description = "Allow all trafic to db"
}

resource "aws_vpc_security_group_ingress_rule" "allow_db_ipv4" {
  security_group_id = aws_security_group.sg_database.id
  cidr_ipv4         = "${aws_eip.lb.public_ip}/32"
  from_port         = var.db_port
  ip_protocol       = "tcp"
  to_port           = var.db_port
}
