variable "region" {
  type        = string
  description = "Deployment region"
  default     = "us-west-2"
}
provider "aws" {
  region = var.region
}
