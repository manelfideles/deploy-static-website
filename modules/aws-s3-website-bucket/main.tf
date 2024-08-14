resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.environment}.storage-130824"
  tags   = var.tags
}

resource "aws_s3_bucket_website_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_cors_configuration" "cors" {
  bucket = aws_s3_bucket.s3_bucket.id

  cors_rule {
    allowed_methods = ["GET", "PUT", "POST"]
    allowed_origins = ["*"]
    allowed_headers = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "s3_bucket" {
  bucket     = aws_s3_bucket.s3_bucket.id
  acl        = "public-read"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.bucket_public_access_block]
}

resource "aws_s3_bucket_policy" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource = [
          aws_s3_bucket.s3_bucket.arn,
          "${aws_s3_bucket.s3_bucket.arn}/*"
        ],
      },
    ]
  })
}
