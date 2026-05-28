output "alb_dns_name" {
  description = "ALB DNS name for backend API"
  value       = module.compute.alb_dns_name
}

output "cloudfront_domain" {
  description = "CloudFront domain for frontend"
  value       = module.storage.cloudfront_domain_name
}

output "s3_bucket_name" {
  description = "S3 bucket name for frontend"
  value       = module.storage.s3_bucket_name
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = module.compute.ecr_repository_url
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = module.storage.cloudfront_distribution_id
}

output "backend_log_group" {
  description = "Backend CloudWatch log group"
  value       = module.monitoring.backend_log_group_name
}