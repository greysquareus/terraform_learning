variable "instance_type" {
  
}

data "aws_ec2_instance_type" "free_tier" {
  instance_type = var.instance_type
}

resource "aws_instance" "example" {
  instance_type = "t3.micro"
  ami = ""

  lifecycle {
    precondition {
      condition = data.aws_ec2_instance_type.free_tier.free_tier_eligible
      error_message = "Launch only free-tier ec2!"
    }

    postcondition {
      condition = self.public_ip != ""
      error_message = "Where public ip?"
    }
  }
}