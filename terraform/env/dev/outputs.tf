# VPC Outputs
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}
output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
# ALB Output
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
# EC2 Output
output "ec2_instance_id" {
  value = module.ec2.instance_id
}
# RDS Output
output "rds_db_name" {
  value = module.rds.rds_db_name
}
output "rds_endpoint" {
  value = module.rds.rds_endpoint
  sensitive = true
}
