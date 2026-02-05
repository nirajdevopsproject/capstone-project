variable "primary_region" {
  type    = string
  default = "ap-south-1"
}
variable "environment" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "public_subnet_cidr" {
  type = string
}
variable "public_subnet_cidr_1" {
  type = string
}
variable "az" {
  type = string
}
variable "az_1" {
  type = string
}
variable "ami_id"{
  type=string
}
variable "instance_type" {
  type = string
}
variable "ami_name" {
  type = string
}
variable "primary_bucket_name" {
  type = string
}
variable "dr_bucket_name" {
  type = string
}
variable "dr_region" {
  type=string
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