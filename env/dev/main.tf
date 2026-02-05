terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.primary_region
}
provider "aws" {
  alias = "dr"
  region = var.dr_region
}
module "vpc" {
  source             = "../../modules/vpc"
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_cidr_1 = var.public_subnet_cidr_1
  az                 = var.az
  az_1 = var.az_1
}
resource "aws_security_group" "my_sg" {
  vpc_id = module.vpc.vpc_id
  name = "${var.environment}-sg"
  description = "allow ssh"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol ="-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
module "ec2" {
  source = "../../modules/ec2"
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = module.vpc.public_subnet_id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  name = var.ami_name
  public_ip = true
  environment = var.environment
}
module "s3-dr" {
  source = "../../modules/s3-dr"
  environment = var.environment
  primary_bucket_name=var.primary_bucket_name
  dr_bucket_name=var.dr_bucket_name
  dr_region=var.dr_region
}
resource "aws_security_group" "rds_sg" {
  name        = "${var.environment}-rds-sg"
  description = "Allow MySQL"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.my_sg.id]  # Only EC2 can access DB
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "rds" {
  source = "../../modules/rds"
  environment = var.environment
  db_name = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  instance_class = var.instance_class
  allocated_storage = var.allocated_storage
  subnets_id = [module.vpc.public_subnet_id , module.vpc.public_subnet_id_1]
  vpc_security_groups_ids = [aws_security_group.rds_sg.id]
}
resource "aws_db_snapshot" "primary_snapshot" {
  db_instance_identifier = module.rds.db_instance_id
  db_snapshot_identifier = "${var.environment}-app-db-snapshot"
  depends_on = [ module.rds ]
}
# data "aws_db_snapshot" "primary" {
#   region = var.primary_region
#   db_snapshot_identifier = "${var.environment}-app-db-snapshot"
# }
resource "aws_db_snapshot_copy" "dr_snapshot" {
  provider = aws.dr
  source_db_snapshot_identifier = aws_db_snapshot.primary_snapshot.db_snapshot_arn
  target_db_snapshot_identifier = "${var.environment}-app-db-snapshot-dr"
  depends_on = [aws_db_snapshot.primary_snapshot]
}
resource "aws_db_instance" "dr_restore" {
  provider = aws.dr

  identifier          = "${var.environment}-dr-db"
  instance_class      = "db.t3.micro"
  snapshot_identifier = aws_db_snapshot_copy.dr_snapshot.db_snapshot_arn

  skip_final_snapshot = true
  publicly_accessible = false

  tags = {
    Name        = "${var.environment}-dr-db"
    Environment = var.environment
    Purpose     = "Disaster-Recovery"
  }
}
