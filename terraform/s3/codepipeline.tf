resource "aws_s3_bucket" "codepipeline" {
  bucket = "codepipeline-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  acl    = "private"

  force_destroy = true
}
