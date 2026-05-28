resource "aws_cloudwatch_log_group" "backend" {
  name              = "/starttech/${var.project_name}/backend"
  retention_in_days = 30

  tags = {
    Name        = "${var.project_name}-backend-logs"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "frontend" {
  name              = "/starttech/${var.project_name}/frontend"
  retention_in_days = 30

  tags = {
    Name        = "${var.project_name}-frontend-logs"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.project_name}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "CPU utilization is too high"

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }

  tags = {
    Name        = "${var.project_name}-high-cpu-alarm"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "${var.project_name}-low-cpu"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 20
  alarm_description   = "CPU utilization is low"

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }

  tags = {
    Name        = "${var.project_name}-low-cpu-alarm"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          title  = "EC2 CPU Utilization"
          metrics = [
            ["AWS/EC2", "CPUUtilization", "AutoScalingGroupName", var.asg_name]
          ]
          period = 300
          stat   = "Average"
          region = "us-east-1"
        }
      },
      {
        type = "metric"
        properties = {
          title  = "ALB Request Count"
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", var.alb_arn]
          ]
          period = 300
          stat   = "Sum"
          region = "us-east-1"
        }
      }
    ]
  })
}