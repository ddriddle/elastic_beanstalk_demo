
variable "name" {
  description = "The name of the pipeline"
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

variable "ApplicationName" {
  description = "The Elastic Beanstalk application name (defaults to var.name)"
  default     = ""
}

variable "stageEnv" {
  description = <<EOF
The Name of the Elastic Beanstalk Environment to use for staging
EOF
  default    = "stage"
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

variable "prodEnv" {
  description = <<EOF
The Name of the Elastic Beanstalk Environment to use for production
deployments
EOF
  default    = "production"
}

variable "url" {
  description = <<EOF
A url to the Elastic Beanstalk staging environment to use for testing
EOF
}
