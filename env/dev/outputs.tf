output "vpc" {
  value = module.vpc.vpc_id
}
output "public_subnet" {
  value = module.vpc.public_subnet_id
}
output "ec2_public_ip" {
  value = module.ec2.public_ip
}
output "ec2_private_ip" {
  value = module.ec2.private_id
}
output "ec2_instance_id" {
  value = module.ec2.instance_id
}
output "primary_bucket_name" {
  value = module.s3-dr.primary_bucket_name
}
output "primary_bucket_arn" {
  value = module.s3-dr.primary_bucket_arn
}
output "dr_bucket_name" {
  value = module.s3-dr.dr_bucket_name
}
output "dr_bucket_arn" {
  value = module.s3-dr.dr_bucket_arn
}
output "db_instance_id" {
  value = module.rds.db_instance_id
}
output "db_endpoint" {
  value = module.rds.db_endpoint
}