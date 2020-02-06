variable "bucket_domain_name" {
  description = "The domain name to serve uncached index.html"
  type        = string
}

variable "bucket_origin_id" {
  description = "An id of the bucket to serve index.html"
  type        = string
}

variable "environment" {
  description = "The environment for the cloudfront distribution - will be set as tag and comment"
  type        = string
}