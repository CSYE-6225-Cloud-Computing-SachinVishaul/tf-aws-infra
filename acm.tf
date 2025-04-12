resource "aws_acm_certificate" "dev_cert" {
  count             = var.aws_profile == "dev" ? 1 : 0
  domain_name       = var.dev_domain_name
  validation_method = "DNS"

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "dev_cert_validation" {
  count = var.aws_profile == "dev" ? 1 : 0

  zone_id = var.route53_zone_id
  name    = tolist(aws_acm_certificate.dev_cert[0].domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.dev_cert[0].domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.dev_cert[0].domain_validation_options)[0].resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "dev_cert_validation" {
  count                   = var.aws_profile == "dev" ? 1 : 0
  certificate_arn         = aws_acm_certificate.dev_cert[0].arn
  validation_record_fqdns = [aws_route53_record.dev_cert_validation[0].fqdn]
}
