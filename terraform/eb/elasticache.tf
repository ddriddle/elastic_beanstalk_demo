resource "aws_elasticache_cluster" "default" {
    cluster_id = "django-app-test"
    engine = "memcached"
    node_type = "cache.t2.micro"
    port = 11211
    num_cache_nodes = 1
    parameter_group_name = "default.memcached1.4"
}