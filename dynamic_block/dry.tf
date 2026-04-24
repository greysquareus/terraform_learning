provider "aws" {
  region = "us-east-1"
}

variable "ports" {
  type = list(string)
  default = ["22", "33", "55", "66"]
}

resource "aws_security_group" "web_sg" {
  name        = "allow_rules"
  description = "Allow TLS inbound traffic and all outbound traffic"

  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port = ingress.value
      to_port = ingres.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0"]
    }
  }

  tags = {
    Name = "allow_tls"
  }
}