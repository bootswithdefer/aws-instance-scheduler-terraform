Ported from https://github.com/awslabs/aws-instance-scheduler

This uses the unmodified Lambda function from the AWS solution.  However, it
does not work with the CLI without modifications.  The CLI looks up the
Cloudformation Stack in order to find the Lambda function and since that stack
doesn't exist with this Terraform it won't work.  The function can easily be
modified to change that behavior, but I've not done it here.  Instead I've
provided an example config with Terraform's aws_dynamodb_table_item.

You may also need to define the start and stop tags, I'm not sure if DynamoDB
will throw errors when given empty strings.
