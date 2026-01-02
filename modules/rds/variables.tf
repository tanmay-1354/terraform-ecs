variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_sg_id" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_secret_arn" {
  description = "Secrets Manager ARN containing DB credentials"
  type        = string
}
