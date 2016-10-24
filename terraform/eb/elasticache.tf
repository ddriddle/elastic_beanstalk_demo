resource "aws_elasticache_cluster" "default" {
  cluster_id = "django-protoapp"
  engine = "memcached"
  node_type = "cache.t2.micro"
  port = 11211
  num_cache_nodes = 1
  parameter_group_name = "default.memcached1.4"
  security_group_ids = [
    "${aws_security_group.cache-ec2-sg.id}",
  ]
  tags {
    Name = "roma-protoapp"
  }
}
