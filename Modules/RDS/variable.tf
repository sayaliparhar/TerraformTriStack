variable "prv1_subnet_id" {
  type = string
}

variable "prv2_subnet_id" {
  type = string
}

variable "db-security-group" {
  type = string
}

variable "db_password" {
  description = "The password for the RDS instance"
  type        = string
  sensitive   = true
}
