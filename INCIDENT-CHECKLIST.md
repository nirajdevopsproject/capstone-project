# Incident Response Checklist

## When an Incident Occurs

- [ ] Check CloudWatch alarms
- [ ] Identify impacted component:
  - EC2
  - RDS
  - Network
  - S3
- [ ] Inform team / stakeholders (if applicable)

---

## If EC2 Fails

- [ ] Confirm EC2 instance is terminated or unhealthy
- [ ] Run Jenkins pipeline or:
  ```bash
  terraform apply