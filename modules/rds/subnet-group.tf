resource "aws_db_subnet_group" "this" {
  name       = "prod-rds-subnet-group"
  subnet_ids = var.private_subnet_ids
}
