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

resource "aws_instance" "my_master" {
  ami = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"
  count = 5

  tags = {
    name = "machine-${count.index}"
  }  
}


#----

variable "users" {
  type = list(string)
  default = [ "bob", "mc", "gena" ]
}

resource "aws_iam_user" "users" {
  count = 3
  name = var.users[count.index]
}