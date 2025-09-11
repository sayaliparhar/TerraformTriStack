resource "aws_security_group" "dbsg" {
    name = "database-security-group"
    description = "alllow mysql only"
    vpc_id = var.vpc_id
  
}

resource "aws_vpc_security_group_ingress_rule" "inbound" {
    security_group_id = aws_security_group.dbsg.id
    from_port = "3306"
    #cidr_ipv4 = "0.0.0.0/0"
    referenced_security_group_id = aws_security_group.app-sg.id
    ip_protocol = "tcp"
    to_port = "3306"
  
}

resource "aws_vpc_security_group_ingress_rule" "inbo2" {
   security_group_id = aws_security_group.dbsg.id
   from_port = "22"
   ip_protocol = "tcp"
   #cidr_ipv4 = "0.0.0.0/0"
   referenced_security_group_id = aws_security_group.app-sg.id
   to_port = "22"
}

resource "aws_vpc_security_group_egress_rule" "outbound" {
  security_group_id = aws_security_group.dbsg.id
  ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
}