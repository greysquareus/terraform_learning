provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-*/ubuntu-noble-24.04-amd64-server-*"]
  }
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "allow_tls"
  }
}

locals {
  ports = ["22", "80", "443"]
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  for_each = toset(local.ports)
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.value
  ip_protocol       = "tcp"
  to_port           = each.value
}

resource "aws_vpc_security_group_egress_rule" "allow_ssh_traffic_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


variable "key_name" {}

# Create the key pair
resource "tls_private_key" "web_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS key pair
resource "aws_key_pair" "web_key" {
  key_name   = var.key_name
  public_key = tls_private_key.web_key.public_key_openssh
}

# Save the private key to file
resource "local_file" "private_key_local" {
  content  = tls_private_key.web_key.private_key_pem
  filename = "./${var.key_name}.pem"
  file_permission = "0400"
}

resource "aws_instance" "web" {
  ami = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"
  key_name = aws_key_pair.web_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = tls_private_key.web_key.private_key_pem
    host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [  
        "sudo apt install -y apache2",
        "sudo systemctl start apache2"
    ]
  }
}

output "webserver" {
  value = "Your website is http://${aws_instance.web.public_ip}"
}

# Output the key pair name (optional)
output "key_pair_name" {
  value = aws_key_pair.web_key.key_name
}