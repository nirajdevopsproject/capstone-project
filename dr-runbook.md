# Disaster Recovery (DR) Runbook

## Purpose
This runbook defines the steps to recover the infrastructure and database in case of failures.  
The goal is to minimize downtime (RTO) and data loss (RPO).

---

## Architecture Overview
- Infrastructure managed using Terraform
- Multi-environment: dev / staging / prod
- EC2 for application compute
- RDS for database
- S3 with versioning and cross-region replication
- Jenkins CI/CD for deployment and recovery
- CloudWatch + SNS for monitoring and alerts

---

## Recovery Objectives

### RPO (Recovery Point Objective)
- RDS automated backups retention: **1 day**
- Maximum data loss: **up to 24 hours**

### RTO (Recovery Time Objective)
- EC2 recovery time: **~15 seconds**
- RDS recovery time: **~6 minutes 25 seconds**

---

## Scenario 1: EC2 Instance Failure

### Symptoms
- EC2 instance terminated or unreachable
- Application not responding
- CloudWatch alarm may trigger

### Recovery Steps
1. Identify EC2 failure from AWS Console or CloudWatch alarm
2. Run Jenkins pipeline OR execute:
   ```bash
   terraform apply
