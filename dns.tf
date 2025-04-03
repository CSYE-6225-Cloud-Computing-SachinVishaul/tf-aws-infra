variable "route53_zone_id" {
  description = "The Route53 Hosted Zone ID for the domain"
  type        = string
}

resource "aws_route53_record" "app" {
  zone_id = var.route53_zone_id
  name    = "" # Use "demo" in the demo account, for instance
  type    = "A"

  alias {
    name                   = aws_lb.csye6225_alb.dns_name
    zone_id                = aws_lb.csye6225_alb.zone_id
    evaluate_target_health = true
  }
}
