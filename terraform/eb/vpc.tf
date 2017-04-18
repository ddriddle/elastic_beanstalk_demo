data "aws_vpc" "selected" {
  tags {
    Name = "${var.vpc_short_name}-vpc"
  }
}

module "subnet" {
  source = "../enterprise_subnet_ids"

  vpc_short_name = "${var.vpc_short_name}"
  type           = "public1"
}

data "aws_subnet" "public1-a-net" {
  vpc_id = "${data.aws_vpc.selected.id}"

  tags {
    Name = "${var.vpc_short_name}-public1-a-net"
  }
}
