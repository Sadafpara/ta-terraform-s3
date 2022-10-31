#----------------------SECOND S3------------------

resource "aws_s3_bucket" "ta_s3_backend_bucket" {
  bucket = "ta-backend-s3-bucket"
  lifecycle {
      prevent_destroy = true
  }
  tags = {
    Name        = "ta s3 backend bucket"
    Environment = "test"
  }
}



#versioning

resource "aws_s3_bucket_versioning" "ta_s3_backend_bucket_versioning" {
  bucket = aws_s3_bucket.ta_s3_backend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


#Dynamodb for lock file
resource "aws_dynamodb_table" "s3_backend_lock_table" {
  name           = "s3-backend-lock-table"
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
tags = {
    Name = "s3-backend-lock-table"
  }
}