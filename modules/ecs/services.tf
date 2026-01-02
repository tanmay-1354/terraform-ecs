########################################
# ECS Service – Microservice
########################################
resource "aws_ecs_service" "microservice" {
  name            = "prod-microservice-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.microservice.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.microservice_tg_arn
    container_name   = "microservice"
    container_port   = 3000
  }

  depends_on = [
    aws_ecs_cluster.this
  ]
}

########################################
# ECS Service – WordPress
########################################
resource "aws_ecs_service" "wordpress" {
  name            = "prod-wordpress-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.wordpress.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.wordpress_tg_arn
    container_name   = "wordpress"
    container_port   = 80
  }

  depends_on = [
    aws_ecs_cluster.this
  ]
}
