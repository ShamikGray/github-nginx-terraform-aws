output "alb_dns_name" {
  value       = aws_alb.project_load_balancer.dns_name
  description = "The domain name of the ALB"
}

#output "s3_bucket_id" {
#  value = aws_s3_bucket.terraform_state_backup.id
#}
