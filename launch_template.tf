resource "aws_launch_template" "csye6225_asg" {
  name_prefix   = "csye6225_asg"
  image_id      = var.custom_ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_to_s3_profile.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.csye6225_app_sg.id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
# Retrieve DB password from Secrets Manager
sudo snap install aws-cli --classic

DB_PASSWORD=$(aws secretsmanager get-secret-value --secret-id db_master_password --query SecretString --output text)

# Create or update the environment file
cat <<EOL > /opt/csye6225/.env
DB_URL=${var.db_url}
DB_USERNAME=${var.db_username}
DB_PASSWORD=${var.db_password}
RDS_DB_ENDPOINT=${aws_db_instance.csye6225_rds.address}
S3_BUCKET_NAME=${aws_s3_bucket.csye6225_bucket.bucket}
AWS_REGION=${var.aws_region}
RDS_DB_PASSWORD=$${DB_PASSWORD}
EOL
chmod 644 /opt/csye6225/.env
systemctl restart myapp.service

# Configure and restart the CloudWatch Agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/csye6225/cloudwatch-config.json -s
EOF
  )
}
