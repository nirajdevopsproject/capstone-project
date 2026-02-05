terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}
resource "aws_s3_bucket" "backend_bucket" {
  bucket = "backend-e0cc4b2ea227f042"
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.backend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
