variable "environment" {
  type = string
}
variable "db_name" {
  type = string
}
variable "db_username" {
 type = string 
}
variable "db_password" {
  type = string
  sensitive = false
}
variable "instance_class" {
  type = string
}
variable "allocated_storage"{
  type = number
}
variable "subnets_id" {
  type = list(string)
}
variable "vpc_security_groups_ids" {
  type = list(string)
}