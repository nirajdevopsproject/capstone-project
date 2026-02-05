variable "environment" {
  description = "provider environment"
  type=string
}
variable "ami" {
  description = "provide the ami"
  type=string
}
variable "instance_type" {
  description = "instance type of ec2"
  type=string
}
variable "subnet_id" {
  description = "subnet of ec2"
  type=string
}
variable "vpc_security_group_ids" {
  description = "security ids of ec2"
  type=list(string)
}
variable "name" {
  description = "name of instance"
  type=string
}
variable "public_ip" {
  description = "associating public ip"
  type=bool
  default=false  
}