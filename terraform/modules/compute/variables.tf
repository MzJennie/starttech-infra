variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "ec2_security_group_id" {
  description = "Security group ID for EC2"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security group ID for ALB"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "min_size" {
  description = "Minimum number of EC2 instances"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of EC2 instances"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number
  default     = 2
}

variable "ecr_repository_url" {
  description = "ECR repository URL"
  type        = string
}

variable "mongo_uri" {
  description = "MongoDB Atlas connection string"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "JWT secret key"
  type        = string
  sensitive   = true
}

variable "redis_endpoint" {
  description = "Redis endpoint"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}