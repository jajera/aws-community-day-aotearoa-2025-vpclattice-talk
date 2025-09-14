resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

module "setup_vpc" {
  source = "./modules/vpc"

  name_prefix = local.name_prefix
}

module "setup_ec2" {
  source = "./modules/ec2"

  name_prefix                    = local.name_prefix
  vpc_ids                        = module.setup_vpc.vpc_ids
  security_group_ids             = module.setup_vpc.security_group_ids
  ec2_client_private_subnet_ids  = module.setup_vpc.private_subnet_ids["client"]
  ec2_client_allowed_cidr_blocks = ["${module.setup_vpc.my_public_ip}/32"]
  app_2_private_subnet_ids       = module.setup_vpc.private_subnet_ids["app2"]
}

module "setup_lambda" {
  source = "./modules/lambda"

  name_prefix              = local.name_prefix
  name_suffix              = random_string.suffix.result
  vpc_ids                  = module.setup_vpc.vpc_ids
  security_group_ids       = module.setup_vpc.security_group_ids
  app_1_private_subnet_ids = module.setup_vpc.private_subnet_ids["app1"]
}

module "setup_ecs_fargate" {
  source = "./modules/ecs_fargate"

  name_prefix                = local.name_prefix
  name_suffix                = random_string.suffix.result
  vpc_ids                    = module.setup_vpc.vpc_ids
  security_group_ids         = module.setup_vpc.security_group_ids
  app_2_private_subnet_cidrs = module.setup_vpc.private_subnet_cidrs["app2"]
  app_2_private_subnet_ids   = module.setup_vpc.private_subnet_ids["app2"]
  app_2_public_subnet_cidrs  = module.setup_vpc.public_subnet_cidrs["app2"]
  app_2_public_subnet_ids    = module.setup_vpc.public_subnet_ids["app2"]
}

module "setup_vpc_lattice" {
  source = "./modules/vpc_lattice"

  name_prefix                           = local.name_prefix
  vpc_ids                               = module.setup_vpc.vpc_ids
  security_group_ids                    = module.setup_vpc.security_group_ids
  route53_zone_name                     = local.route53_zone_name
  lambda_arns                           = module.setup_lambda.lambda_arns                        # lambda target example
  ec2_notifications_service_instance_id = module.setup_ec2.ec2_notifications_service_instance_id # instance target example
  analytics_service_alb_arn             = module.setup_ecs_fargate.analytics_service_alb_arn     # alb target example
}

module "setup_vpc_lattice_demo_web_server" {
  source = "./modules/ec2_web_server"

  name_prefix                  = local.name_prefix
  vpc_ids                      = module.setup_vpc.vpc_ids
  security_group_ids           = module.setup_vpc.security_group_ids
  ec2_client_public_subnet_ids = module.setup_vpc.public_subnet_ids["client"]

  depends_on = [
    module.setup_vpc_lattice
  ]
}
