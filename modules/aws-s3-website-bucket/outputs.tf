output "environment" {
  description = "The execution environment"
  value       = var.environment
}

output "aws_s3_bucket_name" {
  description = "Name (id) of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket.id
}

output "aws_s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket.arn
}

output "aws_s3_bucket_id" {
  description = "ID of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket.id
}
