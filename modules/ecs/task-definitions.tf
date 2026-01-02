################################
# Microservice Task Definition
################################
resource "aws_ecs_task_definition" "microservice" {
  family                   = "prod-microservice"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "microservice"
      image     = var.microservice_image
      essential = true

      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/prod-microservice"
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

################################
# WordPress Task Definition
################################
resource "aws_ecs_task_definition" "wordpress" {
  family                   = "prod-wordpress"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"

  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn

  container_definitions = jsonencode([
    {
      name  = "wordpress"
      image = var.wordpress_image
      essential = true

      portMappings = [{
        containerPort = 80
      }]

                    environment = [
                {
                    name  = "WORDPRESS_DB_HOST"
                    value = var.rds_endpoint
                },
                {
                    name  = "WORDPRESS_DB_NAME"
                    value = jsondecode(data.aws_secretsmanager_secret_version.wordpress_db.secret_string)["db_name"]
                },
                {
                    name  = "WORDPRESS_DB_USER"
                    value = jsondecode(data.aws_secretsmanager_secret_version.wordpress_db.secret_string)["db_username"]
                },
                {
                    name  = "WORDPRESS_DB_PASSWORD"
                    value = jsondecode(data.aws_secretsmanager_secret_version.wordpress_db.secret_string)["db_password"]
                }
                ]


      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/prod-wordpress"
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
