variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "asg_name" {
  description = "Auto Scaling Group name"
  type        = string
}

variable "alb_arn" {
  description = "ALB ARN suffix"
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN suffix"
  type        = string
}