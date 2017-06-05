data "aws_caller_identity" "current" {}

data "aws_region" "current" {
  current = true
}

# This is not supported in 8.8 :-(
#data "aws_iam_role" "selected" {
#  role_name = "codePipelineServiceRole"
#}
