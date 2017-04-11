resource "aws_s3_bucket" "default" {
  bucket = "drone-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  acl    = "private"
}
