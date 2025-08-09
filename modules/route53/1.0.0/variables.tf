variable "domain_name" {
  type = string
  description = "Domain name for the cloundFront distribution"
}

variable "hosted_zone_id" {
  type = string
  description = "Hosted zone ID for a CloudFront distribution"
}

variable "zone_id" {
    type = string
    description = "Hosted zone ID of route53"
}

variable "record_name" {
  type = string
  description = "Name of the DNS record"
}