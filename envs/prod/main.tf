module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr = var.vpc_cidr

  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  azs = var.azs
}


module "alb" {
  source = "../../modules/alb"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  certificate_arn    = var.certificate_arn
}

module "iam" {
  source = "../../modules/iam"

  environment = "prod"
}

module "ecs" {
  source = "../../modules/ecs"

  region          = var.region
  

  vpc_id                 = module.vpc.vpc_id
  alb_https_listener_arn = module.alb.alb_https_listener_arn
  alb_sg_id              = module.alb.alb_sg_id
  private_subnet_ids     = module.vpc.private_subnet_ids

  microservice_tg_arn = module.alb.microservice_tg_arn
  wordpress_tg_arn    = module.alb.wordpress_tg_arn

  microservice_image = var.microservice_image
  wordpress_image    = var.wordpress_image

  execution_role_arn = module.iam.ecs_task_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn

  #  FROM SECRETS MODULE
  wordpress_db_secret_arn = module.secrets.secret_arn

  #  FROM RDS MODULE
  rds_endpoint = module.rds.rds_endpoint

  depends_on = [
    module.secrets
  ]
}






module "secrets" {
  source = "../../modules/secrets"

#  secret_name = "prod/wordpress/db-v2"
}

module "rds" {
  source = "../../modules/rds"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  ecs_sg_id          = module.ecs.ecs_sg_id

  db_secret_arn      = module.secrets.secret_arn
  db_instance_class  = "db.t3.micro"

  depends_on = [
    module.secrets
  ]
}

