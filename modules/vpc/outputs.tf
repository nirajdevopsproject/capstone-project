output "vpc_id" {
  value=aws_vpc.main.id
}
output "public_subnet_id"{
  value = aws_subnet.public_subnet.id
}
output "public_subnet_id_1"{
  value = aws_subnet.public_subnet_1.id
}