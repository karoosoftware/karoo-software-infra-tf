
locals {
  s3_origin_id     = var.origin_domain
  website_endpoint = var.origin_domain
}


resource "aws_cloudfront_distribution" "s3_distribution" {

  tags = {
    Name = "karoosoftware"
  }

  origin {
    domain_name = local.website_endpoint
    origin_id   = local.s3_origin_id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled = true
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    viewer_protocol_policy = "redirect-to-https"
    default_ttl            = 50
    max_ttl                = 100
    min_ttl                = 1

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

  }

  custom_error_response {
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 0
  }

  custom_error_response {
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 0
  }

  viewer_certificate {
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
    acm_certificate_arn      = "arn:aws:acm:us-east-1:992468223519:certificate/e1d5fb8d-adb2-44e0-b0fc-634dcc06c50f"
  }
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["GB"]
    }
  }

  aliases = ["www.karoosoftware.co.uk"]
}
