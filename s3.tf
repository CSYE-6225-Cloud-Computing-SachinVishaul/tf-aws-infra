#############################
# S3 Bucket Setup for File Storage
#############################

# Generate a unique bucket name using a random UUID
resource "random_uuid" "s3_bucket_uuid" {}

# Create a private S3 bucket with the generated UUID as its name
resource "aws_s3_bucket" "csye6225_bucket" {
  bucket = random_uuid.s3_bucket_uuid.result
  acl    = "private"

  # Allow Terraform to delete the bucket even if it is not empty
  force_destroy = true

  tags = {
    Name = "csye6225-bucket"
  }
}

# Configure default encryption for the bucket using a separate resource
resource "aws_s3_bucket_server_side_encryption_configuration" "csye6225_bucket_encryption" {
  bucket = aws_s3_bucket.csye6225_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Add a separate lifecycle configuration resource
resource "aws_s3_bucket_lifecycle_configuration" "csye6225_bucket_lifecycle" {
  bucket = aws_s3_bucket.csye6225_bucket.id

  rule {
    id     = "TransitionToStandardIA"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}
