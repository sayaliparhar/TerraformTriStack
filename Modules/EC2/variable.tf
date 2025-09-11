# variables for web-tier (subnet,sg)
variable "pub1_subnet_id"{
    type = string
}

variable "pub2_subnet_id" {
    type = string
  
}

variable "public_security_group_ids" {
  
    type = string
}

# variables for application-tier (subnet,sg)
variable "prv1_subnet_id" {
    type = string
}

variable "prv2_subnet_id" {
    type = string
}

variable "private_security_group_ids" {
    type = string
}

#variables for database-tier (sg)
variable "db-sg" {
  type = string
}

#variable for ami
variable "ami_id" {
  type = string
  default = "ami-02d26659fd82cf299"
}