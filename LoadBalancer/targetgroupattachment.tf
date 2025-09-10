resource "aws_lb_target_group_attachment" "tg_attachment" {
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = var.web_instance
  port             = 80
}