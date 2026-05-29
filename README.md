# StartTech Infrastructure

Terraform infrastructure for the StartTech application deployed on AWS.

## Architecture Overview
- **Frontend**: React app hosted on S3 with CloudFront CDN
- **Backend**: Golang API on EC2 Auto Scaling Group behind ALB
- **Cache**: ElastiCache Redis cluster
- **Database**: MongoDB Atlas
- **Monitoring**: CloudWatch logs and metrics

## Prerequisites
- Terraform >= 1.14
- AWS CLI configured
- AWS account with necessary permissions

## Infrastructure Components
- VPC with public and private subnets across 2 AZs
- Application Load Balancer
- Auto Scaling Group (min: 1, max: 3)
- S3 bucket for frontend
- CloudFront distribution
- ElastiCache Redis cluster
- CloudWatch log groups and alarms
- ECR repository for Docker images
- IAM roles with least-privilege policies

## Quick Start

### 1. Clone the repo
```bash
git clone https://github.com/MzJennie/starttech-infra.git
cd starttech-infra
```

### 2. Configure variables
```bash
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
# Edit terraform.tfvars with your values
```

### 3. Deploy
```bash
export MONGO_URI="your-mongodb-uri"
export JWT_SECRET="your-jwt-secret"
./scripts/deploy-infrastructure.sh
```

### 4. Get outputs
```bash
cd terraform
terraform output
```

## CI/CD Pipeline
The infrastructure pipeline runs automatically on push to `main` when files in `terraform/` change. It runs:
1. Terraform Init
2. Terraform Format Check
3. Terraform Validate
4. Terraform Plan
5. Terraform Apply (main branch only)

## Secrets Required
Add these to GitHub Actions secrets:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `MONGO_URI`
- `JWT_SECRET`
