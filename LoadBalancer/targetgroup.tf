resource "aws_lb_target_group" "target-group" {
    name = "load-balancer-target-group"
    vpc_id = var.vpc_id
    protocol = "HTTP"
    port = 80
    target_type = "instance" 
    health_check {
      path                = "/"
      port                = "80"
      protocol            = "HTTP"
      interval            = 30
      healthy_threshold   = 3
      unhealthy_threshold = 2
      timeout             = 5
}


    tags = {
      Name = "Project-target-group"
    }

}