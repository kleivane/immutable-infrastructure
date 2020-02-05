provider "aws" {
  region = "eu-north-1"
}

resource "aws_s3_bucket" "assets" {
  bucket = "tf-immutable-webapp-assets"
  acl    = "public-read"

  tags = {
    Name = "assets"
  }
}

resource "aws_s3_bucket" "test" {
  bucket = "tf-immutable-webapp-test"
  acl    = "public-read"

  tags = {
    Name        = "test"
    Environment = "test"
  }
}

locals {
  s3_origin_id_test   = "S3-${aws_s3_bucket.test.id}"
  s3_origin_id_assets = "S3-${aws_s3_bucket.assets.id}"
}

resource "aws_cloudfront_distribution" "cloudfront_test" {
  origin {
    domain_name = aws_s3_bucket.test.bucket_regional_domain_name
    origin_id   = local.s3_origin_id_test
  }

  origin {
    domain_name = aws_s3_bucket.assets.bucket_regional_domain_name
    origin_id   = local.s3_origin_id_assets
  }

  # Se https://github.com/terraform-providers/terraform-provider-aws/issues/1994 beskrivelse av "use origin headers"
  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    forwarded_values {
      cookies {
        forward = "none"
      }
      query_string = false
    }

    target_origin_id       = local.s3_origin_id_test
    viewer_protocol_policy = "allow-all"
  }

  ordered_cache_behavior {
    path_pattern    = "assets/*"
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    forwarded_values {
      cookies {
        forward = "none"
      }
      query_string = false
    }

    target_origin_id       = local.s3_origin_id_assets
    viewer_protocol_policy = "allow-all"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Test"
  default_root_object = "index.html"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "test"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# domain_name
output "domain_name_test" {
  value = aws_cloudfront_distribution.cloudfront_test.domain_name
}

