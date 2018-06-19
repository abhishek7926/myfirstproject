resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  name       = "elasticache-subnet-group-${var.private_dns_zone_name}"
  subnet_ids = ["${module.vpc.maintenance_subnet_id}"]
}

resource "aws_security_group" "redis_sg" {
  name = "redis-sg"
  vpc_id     = "${module.vpc.vpc_id}"
  description = "redis-sg"
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

}

resource "aws_elasticache_cluster" "redis_cluster" {
  cluster_id           = "redis-${var.private_dns_zone_name}"
  engine               = "redis"
  subnet_group_name    = "${aws_elasticache_subnet_group.elasticache_subnet_group.name}"
  node_type            = "${var.redis_cache_type}"
  port                 = 6379
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  security_group_ids   = ["${aws_security_group.redis_sg.id}"]
  maintenance_window   = "sat:20:00-sat:22:00"
  apply_immediately    = true
}