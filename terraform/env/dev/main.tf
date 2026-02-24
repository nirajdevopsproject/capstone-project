provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../../modules/vpc"

  project_name         = "capstone"
  environment          = var.env
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  nat_gateway_count    = var.nat_gateway_count
}


module "security" {
  source = "../../modules/security"
  env    = var.env
  my_ip  = var.my_ip
  vpc_id = module.vpc.vpc_id
}
module "alb" {
  source = "../../modules/alb"

  env               = var.env
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security.alb_sg_id
}
module "ec2" {
  source = "../../modules/ec2"
  ami_id = var.ami_id
  instance_type = var.instance_type
  private_subnet_id = module.vpc.private_subnet_ids[0]
  ec2_sg_id = module.security.web_sg_id
  key_name = var.key_name
  environment = var.env
  target_group_arn = module.alb.target_group_arn
}
module "rds" {
  source = "../../modules/rds"

  env                = var.env
  private_subnet_ids = module.vpc.private_subnet_ids
  rds_sg_id          = module.security.rds_sg_id

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}
# module "jenkins" {
#   source = "../../modules/jenkins"

#   env              = var.env
#   ami_id           = var.ami_id
#   instance_type    = var.instance_type
#   key_name         = var.key_name
#   public_subnet_id = module.vpc.public_subnet_ids[0]
#   jenkins_sg_id    = module.security.jenkins_sg_id
# }


