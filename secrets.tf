# secrets.tf

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%^&*()-_=+[]{}<>:?|,.~" # Exclude /@" and space
}

resource "aws_secretsmanager_secret" "db_password_secret" {
  name        = "db_master_password"
  description = "Auto-generated master password for RDS"
  kms_key_id  = aws_kms_key.secrets_key.arn
}

# resource "aws_secretsmanager_secret_rotation" "db_password_rotation" {
#   secret_id = aws_secretsmanager_secret.db_password_secret.id

#   rotation_lambda_arn = aws_lambda_function.rotation_lambda.arn  # Ensure you have a Lambda for rotation
#   rotation_rules {
#     automatically_after_days = 90
#   }
# }


resource "aws_secretsmanager_secret_version" "db_password_secret_version" {
  secret_id     = aws_secretsmanager_secret.db_password_secret.id
  secret_string = random_password.db_password.result
}
