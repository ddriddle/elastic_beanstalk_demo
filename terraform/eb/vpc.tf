data "aws_vpc" "selected" {
  tags {
    Name = "${var.vpc_short_name}-vpc"
  }
}

module "subnet" {
  source = "../as-enterprise-subnet-list"

  vpc_short_name = "${var.vpc_short_name}"
}

data "aws_subnet" "public1-a-net" {
  vpc_id = "${data.aws_vpc.selected.id}"

  tags {
    Name = "${var.vpc_short_name}-public1-a-net"
  }
}
