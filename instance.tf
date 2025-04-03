# resource "aws_instance" "csye6225_app_instance" {
#   ami                         = var.custom_ami_id
#   instance_type               = var.instance_type
#   subnet_id                   = aws_subnet.public[0].id
#   vpc_security_group_ids      = [aws_security_group.csye6225_app_sg.id]
#   associate_public_ip_address = true
#   key_name                    = var.key_name

#   # Attach the IAM instance profile for S3 access
#   iam_instance_profile = aws_iam_instance_profile.ec2_to_s3_profile.name

#   # Disable termination protection
#   disable_api_termination = false

#   root_block_device {
#     volume_size           = 25
#     volume_type           = "gp2"
#     delete_on_termination = true
#   }
#   user_data = <<EOF
# #!/bin/bash
# # Create or update the environment file with dynamic configuration
# cat <<EOL > /opt/csye6225/.env
# DB_URL=${var.db_url}z
# DB_USERNAME=${var.db_username}
# DB_PASSWORD=${var.db_password}
# RDS_DB_ENDPOINT=${aws_db_instance.csye6225_rds.address}
# S3_BUCKET_NAME=${aws_s3_bucket.csye6225_bucket.bucket}
# AWS_REGION=${var.aws_region}
# RDS_DB_PASSWORD=${var.db_master_password}
# EOL

# # Set proper permissions
# chmod 644 /opt/csye6225/.env

# # Restart the application service to load new environment variables
# systemctl restart myapp.service

# # Configure and restart the CloudWatch Agent
# sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/csye6225/cloudwatch-config.json -s
# EOF

#   tags = {
#     Name = "csye6225-app-instance"
#   }
# }
