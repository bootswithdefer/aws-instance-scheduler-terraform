resource "aws_cloudwatch_log_group" "scheduler" {
  name              = var.stack_name
  retention_in_days = var.log_retention_days
}


resource "aws_cloudwatch_event_rule" "scheduler" {
  name                = var.stack_name
  description         = "AWS Instance Scheduler - Rule to trigger instance for scheduler function"
  schedule_expression = var.scheduler_frequency
  is_enabled          = var.scheduling_active
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.scheduler.name
  target_id = "MainFunction"
  arn       = aws_lambda_function.scheduler.arn
}
