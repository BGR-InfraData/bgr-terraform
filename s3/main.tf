#tfsec:ignore:aws-s3-enable-versioning
#tfsec:ignore:aws-s3-enable-bucket-logging
#tfsec:ignore:aws-s3-encryption-customer-key
#tfsec:ignore:aws-s3-enable-bucket-encryption
resource "aws_s3_bucket" "bgr_infra" {
  bucket        = "bgr-infra"
  force_destroy = true

  tags = {
    Name        = "bgr-infra"
    Environment = "production"
  }
}

resource "aws_s3_bucket_public_access_block" "bgr_infra_public_access_block" {
  bucket = aws_s3_bucket.bgr_infra.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}



resource "aws_s3_bucket_policy" "bgr_infra_policy" {
  bucket = aws_s3_bucket.bgr_infra.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowUserAccess"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::${var.aws_account_id}:user/${var.aws_access_iam}" }
        Action    = ["s3:GetObject", "s3:PutObject"]
        Resource  = ["${aws_s3_bucket.bgr_infra.arn}/*"]
      },
    ]
  })
}
