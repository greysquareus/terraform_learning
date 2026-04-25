provider "aws" {
  region = "us-east-2"
}

resource "aws_iam_user" "users" {
  name = "myfriend.${count.index}"
  count = 10
}

# output "arns" {
#   value = aws_iam_user.users[*].arn
# }

/*
output "name" {
  value = aws_iam_user.users[*].name
}
*/

output "mixed" {
  value = zipmap(aws_iam_user.users[*].name, aws_iam_user.users[*].arn)
}