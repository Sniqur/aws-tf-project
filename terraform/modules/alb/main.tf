resource "aws_lb" "alb_test" {
  name               = "my-app-alb"
  internal           = false               # Set to true for an internal ALB
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.public_subnet1_id, var.public_subnet2_id]

  enable_deletion_protection = false
}


resource "aws_lb_target_group" "TG1" {
  name     = "ecs-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
target_type = "ip"
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "example_listener" {
  load_balancer_arn = aws_lb.alb_test.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG1.arn
  }
}