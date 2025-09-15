resource "aws_security_group" "app-sg" {
    name = "application-security-group"
    description = "allow ssh only"
    vpc_id = var.vpc_id
  
}

resource "aws_vpc_security_group_ingress_rule" "in" {
    security_group_id = aws_security_group.app-sg.id
    from_port = "22"
    #cidr_ipv4 = "0.0.0.0/0"
    referenced_security_group_id = aws_security_group.websg.id
    to_port = "22"
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "out" {
    security_group_id = aws_security_group.app-sg.id
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
  
}