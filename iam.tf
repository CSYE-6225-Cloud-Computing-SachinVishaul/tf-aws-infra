resource "aws_iam_role" "ec2_to_s3_role" {
  name = "EC2_to_S3_Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

data "aws_iam_policy_document" "ec2_to_s3_policy_doc" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.csye6225_bucket.arn,
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]
    resources = [
      "${aws_s3_bucket.csye6225_bucket.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "ec2_to_s3_policy" {
  name   = "EC2_to_S3_Policy"
  policy = data.aws_iam_policy_document.ec2_to_s3_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "ec2_to_s3_attach" {
  role       = aws_iam_role.ec2_to_s3_role.name
  policy_arn = aws_iam_policy.ec2_to_s3_policy.arn
}

resource "aws_iam_instance_profile" "ec2_to_s3_profile" {
  name = "EC2_to_S3_Profile"
  role = aws_iam_role.ec2_to_s3_role.name
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent_attach" {
  role       = aws_iam_role.ec2_to_s3_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}



resource "aws_iam_policy" "secrets_kms_policy" {
  name        = "SecretsKMSDecryptPolicyForInstances"
  description = "Allows EC2 instances to decrypt secrets stored with the KMS key"
  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "kms:Decrypt"
        ],
        Resource : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secrets_kms" {
  role       = aws_iam_role.ec2_to_s3_role.name
  policy_arn = aws_iam_policy.secrets_kms_policy.arn
}



resource "aws_iam_policy" "secrets_get_policy" {
  name        = "SecretsGetValuePolicyForInstances"
  description = "Allows EC2 instances to retrieve secrets from Secrets Manager"
  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "secretsmanager:GetSecretValue"
        ],
        Resource : "*" // Or scope it more tightly to your secret ARN, e.g. "arn:aws:secretsmanager:${var.aws_region}:<account-id>:secret:db_master_password*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "attach_secrets_get" {
  role       = aws_iam_role.ec2_to_s3_role.name
  policy_arn = aws_iam_policy.secrets_get_policy.arn
}
