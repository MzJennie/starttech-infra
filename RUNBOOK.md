# Operations Runbook

## Deployment

### Deploy Infrastructure
```bash
cd starttech-infra
export MONGO_URI="your-uri"
export JWT_SECRET="your-secret"
./scripts/deploy-infrastructure.sh
```

### Deploy Frontend
```bash
cd starttech-application
./scripts/deploy-frontend.sh <s3-bucket-name> <cloudfront-id>
```

### Deploy Backend
```bash
cd starttech-application
./scripts/deploy-backend.sh starttech-asg us-east-1
```

## Health Checks

### Check backend health
```bash
./scripts/health-check.sh <alb-dns-name>
```

### Check pods/instances
```bash
aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names starttech-asg \
  --query 'AutoScalingGroups[0].Instances[*].{ID:InstanceId,State:LifecycleState,Health:HealthStatus}'
```

## Rollback

### Rollback backend deployment
```bash
./scripts/rollback.sh starttech-asg us-east-1
```

## Troubleshooting

### Backend not responding
1. Check ALB target group health in AWS Console
2. Check EC2 instance logs in CloudWatch
3. Check `/starttech/starttech/backend` log group

### Frontend not loading
1. Check S3 bucket has files
2. Check CloudFront distribution status
3. Invalidate CloudFront cache if needed

### High CPU alarm triggered
1. Check CloudWatch metrics
2. ASG will auto-scale up if CPU > 80%
3. Check application logs for errors

## Monitoring
- CloudWatch Dashboard: `starttech-dashboard`
- Backend logs: `/starttech/starttech/backend`
- Frontend logs: `/starttech/starttech/frontend`
- CPU alarm: `starttech-high-cpu`