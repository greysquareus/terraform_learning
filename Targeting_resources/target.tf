resource "aws_iam_user" "dev" {
  name = "123"
}

resource "aws_security_group" "sec_group" {
  name = "4343"
}

resource "local_file" "file" {
  content = "weqeqweqweqw"
  filename = "/etc/123.txt"
}