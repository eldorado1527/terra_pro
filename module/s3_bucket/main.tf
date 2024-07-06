resource "aws_s3_bucket" "egbeda_bucket" {
  bucket = "egbeda-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "access" {
  bucket = aws_s3_bucket.egbeda_bucket.bucket

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
  }

resource "aws_s3_object" "web_training" {
  for_each = fileset("${path.root}/module/s3_bucket/web-training", "**/*.*")
  bucket      = aws_s3_bucket.egbeda_bucket.id
  key         = each.value
  source      = "${path.root}/module/s3_bucket/web-training/${each.value}"
  source_hash = filemd5("${path.root}/module/s3_bucket/web-training/${each.value}")
  content_type = each.value
}

  resource "aws_s3_bucket_policy" "akintunde_bucket" {
  bucket = aws_s3_bucket.egbeda_bucket.bucket

    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Effect = "Allow",
            Principal = "*",
            Action = [
            "s3:GetObject"
            ],
            Resource = [
            "${aws_s3_bucket.egbeda_bucket.arn}/*"
            ]
        }
        ]
    })
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.egbeda_bucket.bucket

  index_document {
    suffix = "index.html"
    }
  error_document {
    key = "error.html"
    }
  }