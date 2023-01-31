
resource "aws_s3_bucket" "statefile" {
  bucket = "ali-statfile-lockiti"
}

resource "aws_dynamodb_table" "statefile_lock" {
  name           = "Ali-statefile-lock-table"
  read_capacity  = 1
  write_capacity = 1

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"

  }

  tags = {
    Terraform   = "true"
    Environment = "${terraform.workspace}"

  }
}

terraform {
  backend "s3" {
    bucket = "ali-statfile-lockiti"
    key    = "statefile.tfstate"
    region = "us-east-1"

    dynamodb_table = "Ali-statefile-lock-table"
  }
}
