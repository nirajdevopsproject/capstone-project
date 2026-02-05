resource "aws_instance" "main"{
    ami=var.ami
    instance_type=var.instance_type
    subnet_id=var.subnet_id
    vpc_security_group_ids=var.vpc_security_group_ids
    associate_public_ip_address = var.public_ip
    tags={
        Name="${var.environment}-${var.name}"
        env="${var.environment}"
    }
}
