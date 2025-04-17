provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "state_bucket" {
  bucket = "tf-demo-terraform-state-teagan"
  force_destroy = true
  
}

resource "aws_dynamodb_table" "state_lock_table" {
  name         = "tf-demo-terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
 
  attribute {
    name = "LockID"
    type = "S"
  }

  hash_key = "LockID"

  tags = {
    Name        = "tf-demo-terraform-state-lock"
    Environment = "dev"
  }
}