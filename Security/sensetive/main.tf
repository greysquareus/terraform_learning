variable "password" {
  default = "mypass"
  sensitive = true
}

resource "local_file" "test" {
  content = var.password
  filename = "./test.txt"
}

output "pass" {
  value = var.password
  sensitive = true
}
