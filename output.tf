output "aws_s3_website" {
  value = module.aws_s3_bucket.website_endpoint
}
