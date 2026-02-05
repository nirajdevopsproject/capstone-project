provider "aws" {
  region = "ap-south-1"
}
provider "aws" {
  alias = "dr"
  region = var.dr_region
}
resource "aws_s3_bucket" "primary_bucket" {
  bucket = var.primary_bucket_name
  tags = {
    Name = "${var.environment}-app-bucket"
    env = var.environment
  }
}
resource "aws_s3_bucket_versioning" "primary_versioning" {
  bucket = aws_s3_bucket.primary_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket" "dr_bucket" {
  provider = aws.dr
  bucket = var.dr_bucket_name
  tags = {
    Name = "${var.environment}-dr-bucket"
    env = var.environment
  }
}
resource "aws_s3_bucket_versioning" "dr_versioning" {
  provider = aws.dr
  bucket = aws_s3_bucket.dr_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_iam_role" "replication_role" {
  name = "${var.environment}-s3-replication-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "s3.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "replication_policy" {
  role = aws_iam_role.replication_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["s3:GetReplicationConfiguration", "s3:ListBucket"]
        Resource = [aws_s3_bucket.primary_bucket.arn]
      },
      {
        Effect = "Allow"
        Action = ["s3:GetObjectVersion", "s3:GetObjectVersionAcl"]
        Resource = ["${aws_s3_bucket.primary_bucket.arn}/*"]
      },
      {
        Effect = "Allow"
        Action = ["s3:ReplicateObject", "s3:ReplicateDelete", "s3:ReplicateTags"]
        Resource = ["${aws_s3_bucket.dr_bucket.arn}/*"]
      }
    ]
  })
}

# Replication config
resource "aws_s3_bucket_replication_configuration" "replication" {
  bucket = aws_s3_bucket.primary_bucket.bucket
  role  = aws_iam_role.replication_role.arn

  rule {
    id     = "replicate-to-dr"
    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.dr_bucket.arn
      storage_class = "STANDARD"
    }
  }

  depends_on = [
    aws_s3_bucket_versioning.primary_versioning,
    aws_s3_bucket_versioning.dr_versioning
  ]
}