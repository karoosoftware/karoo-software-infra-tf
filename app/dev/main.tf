terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = "eu-west-2"
}

module "static_website" {
  source      = "../../modules/static-website/1.0.0"
  bucket_name = "www.karoosoftware.co.uk"
}

module "cloudfront_dist" {
  source        = "../../modules/cloudfront_dist/1.0.0"
  origin_domain = module.static_website.website_endpoint
}

module "route53" {
  source      = "../../modules/route53/1.0.0"
  zone_id     = "Z09113681C7TM2UX7F2CQ"
  domain_name = module.cloudfront_dist.dns_domain_name
  hosted_zone_id = module.cloudfront_dist.hosted_zone_id
  record_name = "www.karoosoftware.co.uk"
}
