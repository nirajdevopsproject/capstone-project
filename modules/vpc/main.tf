resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name ="${var.environment}-vpc"
    env=var.environment
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.az
  tags = {
    Name="${var.environment}-public-subnet"
  }
}
resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr_1
  availability_zone = var.az_1
  tags = {
    Name="${var.environment}-public-subnet-1"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name="${var.environment}-igw"
      }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}
resource "aws_route" "public-rt" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "rt-assoc" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "rt-assoc-1" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}