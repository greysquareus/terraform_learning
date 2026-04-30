provider "aws" {
  region = "us-east-1" 
}

import {
  id = "i-08d64ffe14a21fede"
  to = aws_instance.web
}

# resource "aws_instance" "web" {
#   instance_type = "t3.small"
#   ami = "al2023-ami-2023.11.20260413.0-kernel-6.1-x86_64"
# }W