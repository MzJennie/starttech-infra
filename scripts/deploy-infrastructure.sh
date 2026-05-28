#!/bin/bash
set -e

echo "Deploying StartTech Infrastructure..."

cd terraform

echo "Initializing Terraform..."
terraform init

echo "Validating Terraform..."
terraform validate

echo "Planning Terraform..."
terraform plan \
  -var="mongo_uri=${MONGO_URI}" \
  -var="jwt_secret=${JWT_SECRET}"

echo "Applying Terraform..."
terraform apply -auto-approve \
  -var="mongo_uri=${MONGO_URI}" \
  -var="jwt_secret=${JWT_SECRET}"

echo "Infrastructure deployed successfully."
echo "ALB DNS: $(terraform output -raw alb_dns_name)"
echo "CloudFront: $(terraform output -raw cloudfront_domain)"
echo "S3 Bucket: $(terraform output -raw s3_bucket_name)"
echo "ECR URL: $(terraform output -raw ecr_repository_url)"