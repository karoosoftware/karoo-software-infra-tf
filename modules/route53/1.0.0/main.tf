resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = "A"

  alias {
    name                   = var.domain_name
    zone_id                = var.hosted_zone_id
    evaluate_target_health = true
  }
}
