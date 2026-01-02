resource "random_password" "db" {
  length           = 12
  special          = true
  override_special = "!#$%^&*()-_=+[]{}<>:?"
}


resource "aws_secretsmanager_secret" "this" {
  name = var.secret_name
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.id

  secret_string = jsonencode({
    db_name     = "wordpress"
    db_username = "wpadmin"
    db_password = random_password.db.result
  })
}
