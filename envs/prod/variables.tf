variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ACM certificate ARN for ALB HTTPS listener"
  type        = string
}

variable "region" {
  type    = string
  default = "ap-south-1"
}



variable "microservice_image" {
  description = "Docker image for microservice"
  type        = string
}

variable "wordpress_image" {
  description = "Docker image for WordPress"
  type        = string
}

