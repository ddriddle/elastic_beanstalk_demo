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
