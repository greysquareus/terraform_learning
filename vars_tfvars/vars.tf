variable "region" {
  type = string
}

variable "instance_size" {
  type = string
}

variable "vpn" {
  type = string
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