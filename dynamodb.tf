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
  range_key  = aws_dynamodb_table.config.range_key

  item = <<ITEM
{
  "create_rds_snapshot": {
    "BOOL": ${var.create_rds_snapshot}
  },
  "default_timezone": {
    "S": "${var.default_timezone}"
  },
  "name": {
    "S": "scheduler"
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

resource "aws_dynamodb_table_item" "config-period-business-hours" {
  table_name = aws_dynamodb_table.config.name
  hash_key   = aws_dynamodb_table.config.hash_key
  range_key  = aws_dynamodb_table.config.range_key

  item = <<ITEM
{
  "begintime": {
    "S": "07:00"
  },
  "endtime": {
    "S": "19:00"
  },
  "name": {
    "S": "business-hours"
  },
  "type": {
    "S": "period"
  },
  "weekdays": {
    "SS": [
      "mon-fri"
    ]
  }
}
ITEM
}

resource "aws_dynamodb_table_item" "config-schedule-business-hours" {
  table_name = aws_dynamodb_table.config.name
  hash_key   = aws_dynamodb_table.config.hash_key
  range_key  = aws_dynamodb_table.config.range_key

  item = <<ITEM
{
  "enforced": {
    "BOOL": false
  },
  "hibernate": {
    "BOOL": false
  },
  "name": {
    "S": "business-hours"
  },
  "periods": {
    "SS": [
      "business-hours"
    ]
  },
  "retain_running": {
    "BOOL": false
  },
  "stop_new_instances": {
    "BOOL": true
  },
  "timezone": {
    "S": "America/Phoenix"
  },
  "type": {
    "S": "schedule"
  },
  "use_maintenance_window": {
    "BOOL": false
  },
  "use_metrics": {
    "BOOL": false
  }
}
ITEM
}
