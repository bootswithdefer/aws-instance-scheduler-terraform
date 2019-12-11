variable "stack_name" {
  type        = string
  description = "Name of the stack"
  default     = "Scheduler"
}

variable "scheduling_active" {
  type        = bool
  description = "Activate or deactivate scheduling."
  default     = true
}

variable "scheduled_services" {
  type        = string
  description = "Scheduled Services. (ec2, rds, or ec2,rds)"
  default     = "ec2"
}

variable "schedule_clusters" {
  type        = string
  description = "Enable scheduling of Aurora clusters for RDS Service."
  default     = "False"
}

variable "create_rds_snapshot" {
  type        = string
  description = "Create snapshot before stopping RDS instances(does not apply to Aurora Clusters)."
  default     = "True"
}

variable "memory_size" {
  type        = number
  description = "Size of the Lambda function running the scheduler, increase size when processing large numbers of instances"
  default     = 128
}

variable "use_metrics" {
  type        = string
  description = "Collect instance scheduling data using CloudWatch metrics."
  default     = "True"
}

variable "log_retention_days" {
  type        = number
  description = "Retention days for scheduler logs."
  default     = 30
}

variable "trace" {
  type        = string
  description = "Enable logging of detailed informtion in CloudWatch logs."
  default     = "False"
}

variable "tag_name" {
  type        = string
  description = "Name of tag to use for associating instance schedule schemas with service instances."
  default     = "Schedule"
}

variable "default_timezone" {
  type        = string
  description = "Choose the default Time Zone. Default is 'UTC'"
  default     = "UTC"
}

variable "regions" {
  type        = list(string)
  description = "List of regions in which instances are scheduled, leave blank for current region only."
  default     = []
}

variable "cross_account_roles" {
  type        = list(string)
  description = "Comma separated list of ARN's for cross account access roles. These roles must be created in all checked accounts the scheduler to start and stop instances."
  default     = []
}

variable "started_tags" {
  type        = string
  description = "Comma separated list of tagname and values on the formt name=value,name=value,.. that are set on started instances"
  default     = ""
}

variable "stopped_tags" {
  type        = string
  description = "Comma separated list of tagname and values on the formt name=value,name=value,.. that are set on stopped instances"
  default     = ""
}

variable "scheduler_frequency" {
  type        = string
  description = "Scheduler running frequency in minutes."
  default     = "cron(0/5 * * * ? *)"
}

variable "schedule_lambda_account" {
  type        = string
  description = "Schedule instances in this account."
  default     = "True"
}

variable "send_anonymous_data" {
  type        = string
  description = "Send Anonymous Metrics Data."
  default     = "False"
}

variable "function_version" {
  type        = string
  default     = "v1.3.0"
  description = "Instance Scheduler Lambda function version"
}
