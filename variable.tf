variable "region" {
  type = string
  default = "ap-south-1"
}
variable "cloudfront_prefix_list_id" {
  type        = string
  description = "CloudFront managed prefix list ID (origin-facing)"
}

variable "db_password" {
  description = "The password for the RDS instance"
  type        = string
  sensitive   = true
}
