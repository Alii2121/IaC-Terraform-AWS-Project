
# resource "aws_s3_bucket" "statefile" {
#   bucket = "Ali-statefile-bucket-iti"
# }

# resource "aws_dynamodb_table" "statefile_lock" {
#   name = "Ali-statefile-lock-table"


#   hash_key = "LockID"

#   attribute = [
#     {
#       name = "LockID"
#       type = "S"
#     }
#   ]

#   tags = {
#     Terraform   = "true"
#     Environment = "${terraform.workspace}"

#   }
# }

# terraform {
#   backend "s3" {
#     bucket = "Ali-statefile-bucket-iti"
#     key    = "statefile.tfstate"
#     region = "us-east-1"

#     dynamodb_table = "Ali-statefile-lock-table"
#   }
# }
