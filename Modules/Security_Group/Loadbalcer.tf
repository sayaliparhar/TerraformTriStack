resource "aws_security_group" "load" {
  vpc_id = var.vpc_id
  name = "load-balancer-security-group"
  description = "allow http only"
}

resource "aws_vpc_security_group_ingress_rule" "loadin" {
  security_group_id = aws_security_group.load.id
  ip_protocol = "TCP"
  from_port = 80
  to_port = 80
  #cidr_ipv4 = "0.0.0.0/0"
  prefix_list_id = var.cloudfront_prefix_list_id
}

resource "aws_vpc_security_group_egress_rule" "outload" {
  security_group_id = aws_security_group.load.id
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"

}