resource "aws_lb" "loadbalancer" {
  name               = "app-loadbalancer"
  internal           = false
  load_balancer_type = "application"

  security_groups    = [var.load_sg]
  subnets            = [var.pub1_id, var.pub2_id]

  tags = {
    Name = "Project-Load-Balancer"
  }
}
