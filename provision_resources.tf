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