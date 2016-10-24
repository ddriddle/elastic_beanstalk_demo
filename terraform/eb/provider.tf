variable "aws_profile" {
    description = "AWS profile containing authentication credentials"
    default = "default"
}

provider "aws" {
  region    = "us-east-2"
  profile = "${var.aws_profile}"
}
