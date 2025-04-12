resource "aws_lb" "csye6225_alb" {
  name               = "csye6225-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = aws_subnet.public[*].id

  tags = {
    Name = "csye6225-alb"
  }
}

resource "aws_lb_target_group" "csye6225_tg" {
  name     = "csye6225-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    protocol            = "HTTP"
    path                = "/"
  }

  tags = {
    Name = "csye6225-tg"
  }
}

resource "aws_lb_listener" "csye6225_listener" {
  load_balancer_arn = aws_lb.csye6225_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.csye6225_tg.arn
  }
}

# resource "aws_lb_listener" "csye6225_listener_https" {
#   load_balancer_arn = aws_lb.csye6225_alb.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = var.demo_certificate_arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.csye6225_tg.arn
#   }
# }

resource "aws_lb_listener" "csye6225_listener_https" {
  load_balancer_arn = aws_lb.csye6225_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  # Dynamically use the dev ACM certificate if in dev profile; otherwise use the demo certificate ARN.
  certificate_arn = var.aws_profile == "dev" ? aws_acm_certificate.dev_cert[0].arn : var.demo_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.csye6225_tg.arn
  }
}
