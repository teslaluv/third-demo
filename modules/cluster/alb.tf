resource "aws_lb" "test-lb" {
  name               = var.lb-name
  load_balancer_type = var.lb-type
  internal           = false
  subnets            = [for subnet in aws_subnet.public_subnets : subnet.id]
  security_groups = [aws_security_group.lb.id]
}

resource "aws_security_group" "lb" {
  name   = var.sec-group-lb-name
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = var.lb-target-group-name
  port        = var.lb-target-group-port
  protocol    = var.lb-target-group-protocol
  target_type = var.lb-target-group-type
  vpc_id      = aws_vpc.main.id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }
}

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.test-lb.arn
  port              = var.lb-listener-port
  protocol          = var.lb-listener-protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}
