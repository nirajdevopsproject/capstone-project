# Environment Provisioning Guide

## Overview
This project uses Terraform and Jenkins to provision and manage infrastructure across:
- dev
- staging
- prod

Infrastructure includes:
- VPC and networking
- EC2 instances
- RDS database
- S3 buckets with DR replication
- Monitoring and alerts

---

## Deployment Using Jenkins

1. Push code to GitHub repository
2. Jenkins pipeline is triggered
3. Pipeline stages:
   - Deploy Dev (Terraform apply)
   - Deploy Staging (Terraform apply)
   - Manual Approval
   - Deploy Prod (Terraform apply)
4. Jenkins uses AWS credentials / IAM role to provision resources

---

## Manual Deployment (Optional)

From environment folder:
```bash
cd env/dev
terraform init
terraform apply