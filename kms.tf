# # kms.tf

# # KMS key for EC2
# resource "aws_kms_key" "ec2_key" {
#   description         = "KMS key for encrypting EC2 volumes"
#   enable_key_rotation = true
#   rotation_period_in_days = 90
# }

# # KMS key for RDS
# resource "aws_kms_key" "rds_key" {
#   description         = "KMS key for encrypting RDS data"
#   enable_key_rotation = true
#   rotation_period_in_days = 90
# }

# # KMS key for S3
# resource "aws_kms_key" "s3_key" {
#   description         = "KMS key for S3 bucket default encryption"
#   enable_key_rotation = true
#   rotation_period_in_days = 90
# }

# # KMS key for Secrets Manager (for DB password & email credentials)
# resource "aws_kms_key" "secrets_key" {
#   description         = "KMS key for encrypting secrets (DB password and email credentials)"
#   enable_key_rotation = true
#   rotation_period_in_days = 90
# }



resource "aws_kms_key" "ec2_key" {
  description         = "KMS key for encrypting EC2 volumes"
  enable_key_rotation = true # Required base state

  provisioner "local-exec" {
    command = <<EOT
      aws kms enable-key-rotation --key-id ${self.key_id} --rotation-period-in-days 90 --region ${var.aws_region}
    EOT
  }
}



# KMS key for RDS
resource "aws_kms_key" "rds_key" {
  description         = "KMS key for encrypting RDS data"
  enable_key_rotation = true

  provisioner "local-exec" {
    command = <<EOT
      aws kms enable-key-rotation --key-id ${self.key_id} --rotation-period-in-days 90 --region ${var.aws_region}
    EOT
  }
}

# KMS key for S3
resource "aws_kms_key" "s3_key" {
  description         = "KMS key for S3 bucket default encryption"
  enable_key_rotation = true

  provisioner "local-exec" {
    command = <<EOT
      aws kms enable-key-rotation --key-id ${self.key_id} --rotation-period-in-days 90 --region ${var.aws_region}
    EOT
  }
}


# KMS key for Secrets Manager
resource "aws_kms_key" "secrets_key" {
  description         = "KMS key for encrypting secrets"
  enable_key_rotation = true

  provisioner "local-exec" {
    command = <<EOT
      aws kms enable-key-rotation --key-id ${self.key_id} --rotation-period-in-days 90 --region ${var.aws_region}
    EOT
  }
}
