provider "aws" {
  region = "us-east-1"
}

##-----
variable "my_list" {
  default = ["10.0.0.0/0", "10.0.0.1"]
}

output "list" {
  value = var.my_list
}

#-----
variable "my_map" {
  default = {
    type = "good",
    smells = 58,
    teen = 12 
  }
}

output "map" {
  value = var.my_map
}

