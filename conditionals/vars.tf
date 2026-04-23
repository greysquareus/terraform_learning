variable "region" {
  type = string
  default = "eu-north-1"
}

variable "env" {
  type = string
  default = "dev"
}

variable "instance_size" {
  type = string
  default = "t2.micro"
}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-*/ubuntu-noble-24.04-amd64-server-*"]
  }
}