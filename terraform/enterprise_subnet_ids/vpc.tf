data "aws_vpc" "selected" {
  tags {
    Name = "${var.vpc_short_name}-vpc"
  }
}
