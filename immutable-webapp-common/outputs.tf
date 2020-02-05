output "bucket" {
  value       = aws_s3_bucket.assets
  description = "The created bucket for assets across all environments"
}

output "distribution" {
  value       = aws_cloudfront_distribution.cloudfront_env
  description = "The cloudfront distribution created for the specified environment"
}
