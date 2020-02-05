provider "aws" {
  region = "eu-north-1"
}

resource "aws_s3_bucket" "assets" {
  bucket = "tf-immutable-webapp-assets"
  acl    = "public-read"

  tags = {
    Name        = "assets"
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
