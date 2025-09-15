#output value for vpc id
output "vpc_id" {
    value = aws_vpc.vpc1.id
  
}
# output for web-tier (subnetid)
output "pub1_subnet_id" {
    value = aws_subnet.pub1.id
  
}

output "pub2_subnet_id" {
  value = aws_subnet.pub2.id
}

# output values for application-tier (subnetid)

output "prv1_subnet_id" {
    value = aws_subnet.prv1.id
}

output "prv2_subnet_id" {
    value = aws_subnet.prv2.id
}
