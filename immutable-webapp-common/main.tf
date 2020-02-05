resource "aws_s3_bucket" "assets" {
  bucket = "tf-immutable-webapp-assets"
  acl    = "public-read"

  tags = {
    Name = "assets"
  }
}
