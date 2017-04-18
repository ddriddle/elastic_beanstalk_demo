# Do we want a bucket for Drone?
resource "aws_s3_bucket" "drone" {
  bucket = "drone-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  acl    = "private"

  versioning {
    enabled = true
  }

  force_destroy = true
}
