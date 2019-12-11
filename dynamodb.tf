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

resource "aws_dynamodb_table_item" "config" {
  table_name = aws_dynamodb_table.config.name
  hash_key   = aws_dynamodb_table.config.hash_key

  item = <<ITEM
{
  "create_rds_snapshot": {
    "BOOL": ${var.create_rds_snapshot}
  },
  "default_timezone": {
    "S": "${var.default_timezone}"
  },
  "name": {
    "S": "${var.stack_name}"
  },
  "regions": {
    "SS": ${jsonencode(var.regions)}
  },
  "schedule_clusters": {
    "BOOL": ${var.schedule_clusters}
  },
  "schedule_lambda_account": {
    "BOOL": ${var.schedule_lambda_account}
  },
  "scheduled_services": {
    "SS": ${jsonencode(var.scheduled_services)}
  },
  "started_tags": {
    "S": "${var.started_tags}"
  },
  "stopped_tags": {
    "S": "${var.stopped_tags}"
  },
  "tagname": {
    "S": "${var.tag_name}"
  },
  "trace": {
    "BOOL": ${var.trace}
  },
  "type": {
    "S": "config"
  },
  "use_metrics": {
    "BOOL": ${var.use_metrics}
  }
}
ITEM
}
