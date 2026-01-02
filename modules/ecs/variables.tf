variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "alb_sg_id" {
  type = string
}

variable "alb_https_listener_arn" {
  type = string
}

variable "wordpress_tg_arn" {
  type = string
}

variable "microservice_tg_arn" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "wordpress_db_secret_arn" {
  type = string
}

variable "rds_endpoint" {
  type = string
}

variable "wordpress_image" {
  type = string
}

variable "microservice_image" {
  type = string
}
