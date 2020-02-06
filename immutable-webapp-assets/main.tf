provider "aws" {
  region = "eu-north-1"
  version = "~> 2.47"
}
resource "aws_s3_bucket" "assets" {
  bucket = "tf-immutable-webapp-assets"
  acl    = "public-read"

  tags = {
    Name = "assets"
  }
}

output "bucket_asset" {
  value = aws_s3_bucket.assets.id
}
