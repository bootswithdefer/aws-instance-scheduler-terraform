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
