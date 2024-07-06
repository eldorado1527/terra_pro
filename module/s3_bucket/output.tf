output "aws_s3_website" {
    value = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "website_endpoint" {
  value = aws_s3_bucket.egbeda_bucket.website_endpoint
}
