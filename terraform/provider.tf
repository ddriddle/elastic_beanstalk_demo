provider "aws" {
  region  = "us-east-2"

  # avoid accidentally modifying the wrong AWS account
  allowed_account_ids = ["617683844790"]
}
