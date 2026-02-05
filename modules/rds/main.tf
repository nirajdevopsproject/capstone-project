resource "aws_db_subnet_group" "main" {
  name = "${var.environment}-db-subnet-group"
  subnet_ids = var.subnets_id
  tags = {
    Name="${var.environment}-db-subnet-group"
    env=var.environment
  }
}
resource "aws_db_instance" "main" {
  identifier = "${var.environment}-db"
  engine = "mysql"
  engine_version = "8.0"
  instance_class = var.instance_class
  allocated_storage = var.allocated_storage

  db_name = var.db_name
  username = var.db_username
  password = var.db_password
  
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = var.vpc_security_groups_ids

  backup_retention_period = 1
  skip_final_snapshot = true

  publicly_accessible = false
  multi_az = false
  
  tags={
    Name="${var.environment}-rds"
    env=var.environment
  }
}
