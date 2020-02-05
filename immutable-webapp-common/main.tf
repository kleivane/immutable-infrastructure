resource "aws_s3_bucket" "assets" {
  bucket = "tf-immutable-webapp-assets"
  acl    = "public-read"

  tags = {
    Name = "assets"
  }
}

locals {
  s3_origin_id_assets = "S3-${aws_s3_bucket.assets.id}"
}

resource "aws_cloudfront_distribution" "cloudfront_env" {
  origin {
    domain_name = var.bucket_domain_name
    origin_id   = var.bucket_origin_id
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

    target_origin_id       = var.bucket_origin_id
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
  comment             = var.environment
  default_root_object = "index.html"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = var.environment
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
