output "rds_hostname" {
    value = "${aws_db_instance.rds.address}"
}
