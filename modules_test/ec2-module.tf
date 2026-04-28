module "ec2-instance" {
  source  = "./modules/ec2_instance"
  instance_type = "t3.micro"
  aws_region = "us-east-1"
}

