provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}

variable "tags" {
  type = list
  default = ["firstec2", "secondec2"]
}

variable "ami" {
  type = map
  default = {
    "us-west-1" = "123"
    "us-west-2" = "eq2q"
    "us-west-3" = "423"
  }
}


resource "aws_instance" "app-dev" {
  ami = lookup(var.ami, var.region)
  instance_type = "t2.micro"
  count = length(var.tags)

  tags = {
    Name = element(var.tags,count.index)
    CreationDate = formatdate("DD MMM YYYY hh:mm ZZZ",timestamp())
  }
}

