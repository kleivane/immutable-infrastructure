variable "bucket_domain_name" {
  description = "The domain name to serve uncached index.html"
  type        = string
}

variable "bucket_origin_id" {
  description = "An id of the bucket to serve index.html"
  type        = string
}

variable "aliases" {
  description = "Alternate domain names. The first alias will be the one used in certificate creation"
  type        = list(string)
}

variable "zone_id" {
  description = "The hosted zone for DNS record-certificate validation"
  type        = string
}

variable "environment" {
  description = "The environment for the cloudfront distribution - will be set as tag and comment"
  type        = string
}
