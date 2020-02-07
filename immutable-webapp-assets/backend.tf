resource "aws_s3_bucket" "tf-state-storage-s3" {
    bucket = "tf-immutable-infrastructure-remote-state-storage"

    versioning {
      enabled = true
    }

    lifecycle {
      prevent_destroy = true
    }

    tags = {
      Name = "S3 Remote Terraform State Store"
    }
}

terraform {
  backend "s3" {
    bucket = "tf-immutable-infrastructure-remote-state-storage"
    key    = "immutable_web_app_common"
    region = "eu-north-1"
  }
}
