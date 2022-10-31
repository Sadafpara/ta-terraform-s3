resource "aws_s3_bucket" "ta_s3_bucket" {
  bucket = "ta-s3-bucket"
  lifecycle {
      prevent_destroy = true
  }
  tags = {
    Name        = "ta s3 bucket"
    Environment = "test"
  }
}


#versioning

resource "aws_s3_bucket_versioning" "ta_s3_bucket_versioning" {
  bucket = aws_s3_bucket.ta_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

#creating DynamoDB to manage a lock file to prevent multiple parallel deployment

resource "aws_dynamodb_table" "s3-lock-table" {
  name           = "s3-lock-table"
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
tags = {
    Name = "s3-lock-table"
  }
}


# # Adding S3 bucket as trigger to my lambda and giving the permissions
# resource "aws_s3_bucket_notification" "aws_lambda_trigger" {
#   bucket = aws_s3_bucket.ta_s3_bucket.id
#   lambda_function {
#     lambda_function_arn = aws_lambda_function.test_lambda.arn
#     events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]

#   }
# }



