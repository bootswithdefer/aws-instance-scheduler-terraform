resource "aws_dynamodb_table" "state" {
  name         = "SchedulerState"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "service"
  range_key    = "account-region"

  attribute {
    name = "service"
    type = "S"
  }

  attribute {
    name = "account-region"
    type = "S"
  }
}

resource "aws_dynamodb_table" "config" {
  name         = "SchedulerConfig"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "type"
  range_key    = "name"

  attribute {
    name = "type"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }
}
