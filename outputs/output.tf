provider "aws" {
  region = "us-east-2"
}

##latest ubuntu for us-east-2------------------
data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-*/ubuntu-noble-24.04-amd64-server-*"]
  }
}
####-------------

resource "aws_vpc" "db" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "database"
  }
}

resource "aws_subnet" "db" {
  vpc_id            = aws_vpc.db.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "database"
  }
}

resource "aws_internet_gateway" "db" {
  vpc_id = aws_vpc.db.id
}

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.db.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.db.id
  }
}

resource "aws_security_group" "sg_database" {
  name        = "db_acess"
  description = "Allow all trafic to db"
  vpc_id      = aws_vpc.db.id

  tags = {
    Name = "allow_db"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_db_ipv4" {
  security_group_id = aws_security_group.sg_database.id
  cidr_ipv4         = "${aws_eip.lb.public_ip}/32"
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg_database.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


#aws instance
resource "aws_instance" "web" {
  ami = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"
  subnet_id              = aws_subnet.db.id
  vpc_security_group_ids = [aws_security_group.sg_database.id]
}


#static ip
resource "aws_eip" "lb" {
  instance = aws_instance.web.id
  domain   = "vpc"
}

output "ip" {
  value = aws_eip.lb.public_ip
}

output "dns" {
  value = aws_eip.lb.public_dns
}