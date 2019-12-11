resource "aws_sns_topic" "scheduler" {
  name = var.stack_name
}
