resource "aws_db_instance" "this" {
  identifier        = "prod-wordpress-db"
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string)["db_name"]
  username = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string)["db_username"]
  password = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string)["db_password"]

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.this.name

  skip_final_snapshot = true
}
