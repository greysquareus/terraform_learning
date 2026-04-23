provider "aws" {
  region = var.env == "prod"? "us-east-1": "us-east-2"
}

resource "aws_instance" "web" {
  instance_type = var.env == "prod" ? "t2.small": "t2.micro"
  ami = data.aws_ami.latest_ubuntu.id
}

#-----
resource "aws_instance" "web_instance" {
  instance_type = var.env == "prod" && var.region == "us-east-1" ? "t2.small": "t2.micro"
  ami = data.aws_ami.latest_ubuntu.id
}