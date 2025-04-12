output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

# output "instance_public_ip" {
#   description = "Public IP of the deployed instance"
#   value       = aws_instance.csye6225_app_instance.public_ip
# }

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.csye6225_rds.address
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket created for file storage"
  value       = aws_s3_bucket.csye6225_bucket.bucket
}

output "alb_dns_name" {
  description = "DNS name of the application load balancer"
  value       = aws_lb.csye6225_alb.dns_name
}

output "launch_template_id" {
  description = "The ID of the Launch Template used for the autoscaling group"
  value       = aws_launch_template.csye6225_asg.id
}

output "autoscaling_group_name" {
  description = "The name of the Autoscaling Group"
  value       = aws_autoscaling_group.csye6225_asg.name
}
