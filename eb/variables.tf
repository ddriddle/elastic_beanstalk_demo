variable "name" {
  description = "The name of the application, must be unique within your account"
}

variable "description" {
  description = "Short description of the application"
  default     = ""
}

variable "vpc_short_name" {
  description = "The short name of your VPC, e.g. foobar if the full name is aws-foobar-vpc"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources that support tagging"
  default     = {}
}

variable "role_name" {
  description = "The friendly IAM role name to use with this pipeline"
  default     = "codePipelineServiceRole"
}

variable "inBucket" {
  description = <<EOF
The S3 bucket where AWS CodePipeline retrieves artifacts
(defaults to drone-region-aws account number)
EOF
  default     = ""
}

variable "outBucket" {
  description = <<EOF
The S3 bucket where AWS CodePipeline stores artifacts
(defaults to codepipeline-region-aws account number)
EOF
  default     = ""
}

variable qaaComment {
  description = <<EOF
This comment will be displayed to the QAA approver in an email
notification or the console
EOF
  default = "Please review this release."
}

variable ownerComment {
  description = <<EOF
This comment will be displayed to the Product Owner in an email
notification or the console
EOF
  default = "Please review this release."
}

variable "stage_name" {
  description = <<EOF
The Name of the Elastic Beanstalk Environment to use for staging
EOF
  default    = "stage"
}

variable "prod_name" {
  description = <<EOF
The Name of the Elastic Beanstalk Environment to use for production
deployments
EOF
  default    = "production"
}
