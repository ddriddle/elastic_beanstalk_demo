variable "aws_profile" {
    description = "AWS profile containing authentication credentials"
    default = "default"
}

provider "aws" {
    region  = "us-west-2"
    profile = "${var.aws_profile}"
}
