data "aws_caller_identity" "current" {}

resource "aws_lambda_function" "scheduler" {
  function_name = "${var.stack_name}-InstanceSchedulerMain"
  description   = "EC2 and RDS instance scheduler"
  role          = aws_iam_role.scheduler.arn
  handler       = "main.lambda_handler"
  runtime       = "python3.7"
  memory_size   = var.memory_size
  timeout       = 300
  s3_bucket     = "solutions-${var.region}"
  s3_key        = "aws-instance-scheduler/${var.function_version}/instance-scheduler.zip"

  environment {
    variables = {
      CONFIG_TABLE           = aws_dynamodb_table.config.id
      SCHEDULER_FREQUENCY    = var.scheduler_frequency
      TAG_NAME               = var.tag_name
      STATE_TABLE            = aws_dynamodb_table.state.id
      LOG_GROUP              = var.stack_name
      ACCOUNT                = data.aws_caller_identity.current.account_id
      ISSUES_TOPIC_ARN       = aws_sns_topic.scheduler.arn
      STACK_NAME             = var.stack_name
      BOTO_RETRY             = "5,10,30,0.25"
      ENV_BOTO_RETRY_LOGGING = "False"
      SEND_METRICS           = var.send_anonymous_data
      SOLUTION_ID            = "S00030"
      TRACE                  = var.trace
      METRICS_URL            = "https://metrics.awssolutionsbuilder.com/generic"
      SCHEDULER_RULE         = aws_cloudwatch_event_rule.scheduler.name
    }
  }
}

resource "aws_lambda_permission" "scheduler" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.scheduler.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.scheduler.arn
}
