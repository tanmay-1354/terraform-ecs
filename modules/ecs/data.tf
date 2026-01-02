data "aws_secretsmanager_secret_version" "wordpress_db" {
  secret_id = var.wordpress_db_secret_arn

  depends_on = [
    aws_ecs_cluster.this
  ]
}
