output "public_ip" {
  description = "return the public ip"
  value = aws_instance.main.public_ip
}
output "private_id" {
  description = "return the private ip"
  value = aws_instance.main.private_ip
}
output "instance_id" {
  description = "ec2 instance id"
  value=aws_instance.main.id
}