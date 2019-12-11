data "aws_iam_policy_document" "scheduler" {
  statement {
    effect = "Allow"

    resources = [
      aws_cloudwatch_log_group.scheduler.arn,
      "arn:aws:logs:*:*:log-group:/aws/lambda/*",
    ]

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutRetentionPolicy",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["arn:aws:rds:*:*:snapshot:*"]

    actions = [
      "rds:DeleteDBSnapshot",
      "rds:DescribeDBSnapshots",
      "rds:StopDBInstance",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["arn:aws:rds:*:*:db:*"]

    actions = [
      "rds:AddTagsToResource",
      "rds:RemoveTagsFromResource",
      "rds:DescribeDBSnapshots",
      "rds:StartDBInstance",
      "rds:StopDBInstance",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["arn:aws:rds:*:*:cluster:*"]

    actions = [
      "rds:AddTagsToResource",
      "rds:RemoveTagsFromResource",
      "rds:StartDBCluster",
      "rds:StopDBCluster",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["arn:aws:ec2:*:*:instance/*"]

    actions = [
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:CreateTags",
      "ec2:DeleteTags",
    ]
  }

  statement {
    effect = "Allow"

    resources = [
      aws_dynamodb_table.state.arn,
      aws_dynamodb_table.config.arn,
    ]

    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWriteItem",
    ]
  }

  statement {
    effect = "Allow"
    resources = [
      aws_sns_topic.scheduler.arn,
    ]
    actions = ["sns:Publish"]
  }

  statement {
    effect = "Allow"
    resources = [
      aws_lambda_function.scheduler.arn,
    ]
    actions = ["lambda:InvokeFunction"]
  }

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "logs:DescribeLogStreams",
      "rds:DescribeDBClusters",
      "rds:DescribeDBInstances",
      "ec2:DescribeInstances",
      "ec2:DescribeRegions",
      "ec2:ModifyInstanceAttribute",
      "cloudwatch:PutMetricData",
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:DescribeMaintenanceWindows",
      "tag:GetResources",
      "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_policy" "scheduler" {
  name        = "SchedulerPolicy"
  description = "AWS Instance Scheduler"

  policy = data.aws_iam_policy_document.scheduler.json
}

data "aws_iam_policy_document" "scheduler_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}


resource "aws_iam_role" "scheduler" {
  name        = "Scheduler"
  description = "AWS Instance Scheduler"

  assume_role_policy = data.aws_iam_policy_document.scheduler_assume_role.json
}

resource "aws_iam_role_policy_attachment" "scheduler" {
  role       = aws_iam_role.scheduler.name
  policy_arn = aws_iam_policy.scheduler.arn
}
