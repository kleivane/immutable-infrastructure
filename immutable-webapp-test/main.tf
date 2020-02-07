provider "aws" {
  region = "eu-north-1"
  version = "~> 2.47"
}

resource "aws_s3_bucket" "test" {
  bucket = "tf-immutable-webapp-test"
  acl    = "public-read"

  tags = {
    Name        = "test"
    Environment = "test"
  }
}

module "immutable_cloudfront" {
  source = "../modules/immutable-webapp-common"

  bucket_origin_id = "S3-${aws_s3_bucket.test.id}"
  bucket_domain_name = aws_s3_bucket.test.bucket_regional_domain_name
  environment= "test"
}

output "bucket_asset" {
  value = module.immutable_cloudfront.bucket.id
}

output "bucket_test" {
  value = aws_s3_bucket.test.id
}

output "domain_name_test" {
  value = module.immutable_cloudfront.distribution.domain_name
}
