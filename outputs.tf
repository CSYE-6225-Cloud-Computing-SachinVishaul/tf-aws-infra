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