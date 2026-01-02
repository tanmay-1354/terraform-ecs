resource "aws_cloudwatch_log_group" "microservice" {
  name              = "/ecs/prod-microservice"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "wordpress" {
  name              = "/ecs/prod-wordpress"
  retention_in_days = 7
}
