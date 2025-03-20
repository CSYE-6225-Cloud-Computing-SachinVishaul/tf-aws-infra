output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "instance_public_ip" {
  description = "Public IP of the deployed instance"
  value       = aws_instance.csye6225_app_instance.public_ip
}

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.csye6225_rds.address
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket created for file storage"
  value       = aws_s3_bucket.csye6225_bucket.bucket
}