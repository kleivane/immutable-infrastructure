output "bucket" {
  value       = aws_s3_bucket.assets
  description = "The created bucket for assets across all environments"
}
