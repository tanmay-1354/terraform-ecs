resource "aws_ecs_cluster" "this" {
  name = "prod-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "prod-ecs-cluster"
  }
}
