resource "random_string" "bucket" {
  length    = 5
  min_lower = 5
  special   = false
}

resource "aws_s3_bucket" "main" {
  bucket = "slackbot-lambda-${random_string.bucket.result}"

  # For development purposes
  force_destroy = true
}
