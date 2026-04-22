provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  instance_type = var.instance_size
  ami = data.aws_ami.latest_ubuntu.id
  vpc_security_group_ids = ["${aws_security_group.sg_database.id}"]
}



resource "aws_security_group" "sg_database" {
  name        = "db_acess"
  description = "Allow all trafic to db"

  tags = {
    Name = "allow_db"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_db_ipv4" {
  security_group_id = aws_security_group.sg_database.id
  cidr_ipv4         = var.vpn
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg_database.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

output "vpn_ip" {
  value = var.vpn
}
