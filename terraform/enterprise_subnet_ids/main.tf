# If aws_subnet_ids support filtering by tag we can get rid of this module!
# https://www.terraform.io/docs/providers/aws/d/subnet_ids.html

data "aws_subnet" "default" {
  count  = "${lookup(var.count, var.vpc_short_name, 2)}"
  vpc_id = "${data.aws_vpc.selected.id}"

  tags {
    Name = "${format("%s-%s-%s-net", var.vpc_short_name, var.type, element(var.abc, count.index))}"
  }
}

output "ids" {
  value = ["${data.aws_subnet.default.*.id}"]
}
