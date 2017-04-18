variable "vpc_short_name" {
  description = "The short name of your VPC, e.g. foobar if the full name is aws-foobar-vpc"
}

variable "type" {
  description = "The subnet type to search for, e.g., public1, private1, campus1, etc."
}

variable "count" {
  type = "map"

  default = {
    techsvcsandbox     = 2
    techservicesastest = 3
    techservicesas1    = 3
  }
}

variable "abc" {
  type    = "list"
  default = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l"]
}
