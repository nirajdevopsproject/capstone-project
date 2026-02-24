variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "my_ip" {
  description = "My public IP for SSH access"
  type        = string
}
