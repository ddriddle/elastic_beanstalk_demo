output "eb_cname" {
    value = "${aws_elastic_beanstalk_environment.tfenvtest.cname}"
}
output "rds_hostname" {
    value = "${aws_db_instance.rds.address}"
}
output "elasticache_cluster_address" {
    value = "${aws_elasticache_cluster.default.cluster_address}"
}
output "elasticache_endpoint" {
    value = "${aws_elasticache_cluster.default.configuration_endpoint}"
}
