variable "region" {}
variable "env" {}
variable "my_ip" {}
variable "ami_id" {}
variable "instance_type" {
  default = "t2.micro"
}
variable "key_name" {}

variable "db_name" {}
variable "db_username" {}
variable "db_password" {
  sensitive = true
}
variable "vpc_cidr" {}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "nat_gateway_count" {
  default = 1
}
