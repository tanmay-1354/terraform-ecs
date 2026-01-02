resource "aws_lb" "this" {
  name               = "prod-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "prod-alb"
  }
}
