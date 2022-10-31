#CREATING AWS DYNAMODB TABLE

resource "aws_dynamodb_table" "dynamodb_table" {
  name     = "images-meta-tables"
  hash_key = "image_name"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "image_name"
    type = "S"
  }
}