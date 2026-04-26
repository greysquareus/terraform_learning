provider "aws" {
  region = "us-east-2"
}

#variable "users_list" {
#  type = list(string)
#  default = [ "vasya", "vasya", "vasya", "kolya", "kolya"]
#}

variable "users_set" {
 type = set(string)
 default = [ "vasya", "vasya", "vasya", "kolya", "kolya" ]
}

output "users_list" {
  value = var.users_set
}
