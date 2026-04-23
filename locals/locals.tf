provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-*/ubuntu-noble-24.04-amd64-server-*"]
  }
}

locals {
  common_tags = {
    owner = "Greysquare-with-${data.aws_ami.latest_ubuntu.id}-ami"
    CreationTimestamp =  formatdate("DD MMM YYYY hh:mm ZZZ",timestamp())
  }
}

resource "aws_instance" "ec2" {
  ami = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"
  tags = local.common_tags
}

output "name" {
  value = aws_instance.ec2.tags
}