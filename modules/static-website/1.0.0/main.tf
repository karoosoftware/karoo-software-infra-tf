
resource "aws_s3_bucket" "karoosoftware-static-web" {
  bucket = var.bucket_name
  force_destroy = true

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_website_configuration" "karoosoftware_static-web" {
  bucket = aws_s3_bucket.karoosoftware-static-web.id
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "karoosoftware_public_access" {
  bucket = aws_s3_bucket.karoosoftware-static-web.id

  restrict_public_buckets = false
  block_public_acls = false 
  block_public_policy = false 
  ignore_public_acls = false 
}

resource "aws_s3_bucket_policy" "static_site_policy" {
  bucket = aws_s3_bucket.karoosoftware-static-web.id
  policy = data.aws_iam_policy_document.static_site_policy.json

  depends_on = [
    aws_s3_bucket_public_access_block.karoosoftware_public_access
  ]
}


# Generate the policy document
data "aws_iam_policy_document" "static_site_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.karoosoftware-static-web.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}