# Architecture Documentation

## System Architecture

### Frontend
- React application built with Vite
- Static files hosted on S3
- Served globally via CloudFront CDN
- HTTPS enforced via CloudFront

### Backend
- Golang API application
- Containerized with Docker
- Deployed to EC2 via Auto Scaling Group
- Load balanced via Application Load Balancer
- Health checks on /health endpoint

### Database
- MongoDB Atlas (cloud-hosted)
- Connection via mongodb+srv URI
- Accessible from EC2 instances

### Cache
- ElastiCache Redis cluster
- Used for session management and caching
- Deployed in private subnets

### Networking
- VPC: 10.0.0.0/16
- Public subnets: 10.0.1.0/24, 10.0.2.0/24
- Private subnets: 10.0.3.0/24, 10.0.4.0/24
- Internet Gateway for public access
- Security groups for each component

### Security
- EC2 instances only accept traffic from ALB
- Redis only accepts traffic from EC2
- S3 bucket only accessible via CloudFront
- IAM roles with least-privilege access
- Secrets managed via GitHub Actions secrets

## Data Flow
1. User requests go to CloudFront
2. CloudFront serves static files from S3
3. API calls go to ALB
4. ALB routes to healthy EC2 instances
5. EC2 connects to MongoDB Atlas and Redis