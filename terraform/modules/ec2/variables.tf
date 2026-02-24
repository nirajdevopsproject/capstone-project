variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "private_subnet_id" {}
variable "target_group_arn" {}
variable "environment" {
  type = string
}
variable "ec2_sg_id" {
  type = string
}

