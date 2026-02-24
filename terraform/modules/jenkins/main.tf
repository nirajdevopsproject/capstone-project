# resource "aws_instance" "jenkins" {
#   ami                         = var.ami_id
#   instance_type               = var.instance_type
#   subnet_id                   = var.public_subnet_id
#   vpc_security_group_ids      = [var.jenkins_sg_id]
#   key_name                    = var.key_name
#   associate_public_ip_address = true
#   iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name
#   user_data = <<-EOF
#               #!/bin/bash
#               yum install -y java-17-amazon-corretto
#               yum install -y wget
#               wget -O /etc/yum.repos.d/jenkins.repo \
#               https://pkg.jenkins.io/redhat-stable/jenkins.repo
#               rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#               yum install -y jenkins
#               systemctl enable jenkins
#               systemctl start jenkins
#               # Install Ansible
#               amazon-linux-extras enable ansible2
#               yum install -y ansible
#               # Verify Ansible
#               ansible --version
#               # Allow Jenkins user to run Ansible without password
#               echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
#               EOF

#   tags = {
#     Name = "${var.env}-jenkins"
#   }
# }
# resource "aws_iam_role" "jenkins_role" {
#   name = "${var.env}-jenkins-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       }
#     }]
#   })
# }
# resource "aws_iam_role_policy_attachment" "jenkins_admin" {
#   role       = aws_iam_role.jenkins_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }
# resource "aws_iam_instance_profile" "jenkins_profile" {
#   name = "${var.env}-jenkins-profile"
#   role = aws_iam_role.jenkins_role.name
# }