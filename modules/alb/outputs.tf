output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "alb_https_listener_arn" {
  value = aws_lb_listener.https.arn
}

output "wordpress_tg_arn" {
  value = aws_lb_target_group.wordpress.arn
}

output "microservice_tg_arn" {
  value = aws_lb_target_group.microservice.arn
}
