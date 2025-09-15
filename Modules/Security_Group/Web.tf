resource "aws_security_group" "websg"{
    name = "web-security-group"
    description = "allow ssh and http"
    vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "inbound1" {
    security_group_id = aws_security_group.websg.id
    from_port = "22"
    referenced_security_group_id = aws_security_group.load.id
    ip_protocol = "tcp"
    to_port = "22"
  
}

resource "aws_vpc_security_group_ingress_rule" "inbound2" {
    security_group_id = aws_security_group.websg.id
    from_port = "80"
    referenced_security_group_id = aws_security_group.load.id
    ip_protocol = "tcp"
    to_port = "80"
  
}

resource "aws_vpc_security_group_egress_rule" "outbound1" {
    security_group_id = aws_security_group.websg.id
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
}