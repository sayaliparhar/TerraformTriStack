#output-value for web-security group id
output "web-sg-id" {
    value = aws_security_group.websg.id
  
}

#output-value for app-security group id
output "app-sg-id" {
    value = aws_security_group.app-sg.id
  
}

#output-value for db-security group id
output "db-sg-id" {
    value = aws_security_group.dbsg.id
  
}

#output value for load-balancer-sg 
output "load-sg" {
  value = aws_security_group.load.id
}
