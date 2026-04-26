variable "db_password" {
  type = string
  description = "Password for database"

  validation {
    condition = length(var.db_password) >= 12
    error_message = "DB password must be at least 12 characters long"
  }
}