provider "aws" {
  region = "us-east-2"
}

data "aws_iam_roles" "data" {}

data "aws_security_groups" "sg" {}

data "local_file" "file" {
  filename = "${path.module}/demo.txt"
}

output "name" {
  value = data.aws_security_groups.sg.ids
}

output "output" {
  value = data.aws_iam_roles.data.names
}

output "output_local" {
  value = data.local_file.file
}