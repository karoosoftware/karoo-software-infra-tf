output "website_endpoint" {
  value = module.static_website.website_endpoint
}
output "dns_domain_name" {
  value = module.cloudfront_dist.dns_domain_name
}
output "hosted_zone_id" {
  value = module.cloudfront_dist.hosted_zone_id
}