output "alb_dns_name" {
  value       = aws_alb.project_load_balancer.dns_name
  description = "The domain name of the ALB"
}
