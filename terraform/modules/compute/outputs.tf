output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "alb_arn" {
  value = aws_lb.main.arn
}

output "ecr_repository_url" {
  value = aws_ecr_repository.backend.repository_url
}

output "asg_name" {
  value = aws_autoscaling_group.backend.name
}

output "target_group_arn" {
  value = aws_lb_target_group.backend.arn
}