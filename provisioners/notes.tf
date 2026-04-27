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

resource "aws_instance" "web" {
  ami = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"

  provisioner "local-exec" {
    command = "echo Working id is ${data.aws_ami.latest_ubuntu.id} > 1.txt "

  }


  provisioner "local-exec" {
    command = "echo Working id is ${data.aws_ami.latest_ubuntu.id} > 1.txt "
    when = create
  }
  provisioner "local-exec" {
    command = "echo Working id is ${data.aws_ami.latest_ubuntu.id} > 1.txt "
    when = destroy
  }


  provisioner "local-exec" {
    command = "echo Working id is ${data.aws_ami.latest_ubuntu.id} > 1.txt "
    on_failure = continue
  }

  provisioner "local-exec" {
    command = "echo Working id is ${data.aws_ami.latest_ubuntu.id} > 1.txt "
    on_failure = fail
  }
}