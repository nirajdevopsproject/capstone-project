You can also add this section to your README:

```md
## Disaster Recovery Metrics

- RPO: ~24 hours (based on 1-day RDS backup retention)
- RTO:
  - EC2: ~15 seconds
  - RDS: ~6 minutes 25 seconds

DR was validated by:
- Terminating EC2 and recreating via Terraform
- Restoring RDS from snapshot
- Measuring real recovery times
