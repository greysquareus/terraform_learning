provider "aws" {
  region = "us-east-2"
}

resource "aws_iam_user" "requires_user" {
  name = "myuser"
}


moved {
  from = aws_iam_user.user
  to = aws_iam_user.requires_user
}
