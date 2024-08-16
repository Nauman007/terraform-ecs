module "vpc" {
  source              = "./modules/vpc"
  env                 = var.env
  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  create_nat_gateway  = var.create_nat_gateway
  default_tags        = var.default_tags
}

module "acm" {
  source       = "./modules/acm"
  env          = var.env
  project_name = var.project_name
  default_tags = var.default_tags
  domain_name  = var.domain_name
}

module "ecs" {
  source       = "./modules/ecs-cluster"
  env          = var.env
  project_name = var.project_name
  default_tags = var.default_tags
}

module "loadbalancer" {
  source            = "./modules/elb"
  env               = var.env
  project_name      = var.project_name
  default_tags      = var.default_tags
  public_subnet_ids = module.vpc.public_subnet_ids
  sg_id             = module.vpc.lb_sg_id
}