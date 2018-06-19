resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  name       = "tf-test-cache-subnet"
  subnet_ids = ["${module.vpc.maintenance_subnet_id}"]
}

resource "aws_security_group" "redis_sg" {
  name = "redis-sg"
  vpc_id     = "${module.vpc.vpc_id}"
  description = "redis-sg"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_elasticache_cluster" "redis_cluster" {
  cluster_id           = "redis-${var.private_dns_zone_name}"
  engine               = "redis"
  subnet_group_name    = "${aws_elasticache_subnet_group.elasticache_subnet_group.name}"
  node_type            = "${var.elastic_redis_cluster_type}"
  port                 = 6379
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  security_group_ids   = ["${aws_security_group.redis_sg.id}"]
  maintenance_window   = "sun:20:00-sun:22:00"
  apply_immediately    = true
}

resource "aws_route53_record" "elastic_redis_route53_entry" {
  zone_id    = "${module.vpc.private_route53_zone_id}"
  name       = "disha-redis-elastic-cache"
  type       = "CNAME"
  ttl        = "60"
  records    = ["${aws_elasticache_cluster.redis_cluster.cache_nodes.0.address}"]
}

resource "aws_cloudwatch_metric_alarm" "elastic_redis_cpuutilization" {
  alarm_name = "${var.env}-elastic-redis-High-CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "CPUUtilization"
  namespace = "AWS/ElastiCache"
  period = 300
  statistic = "Average"
  threshold = 80
  alarm_description = "This metric monitor CPU utilization of redis"
  alarm_actions = ["${module.disha_sns.sns_arn}"]
  insufficient_data_actions = ["${module.disha_sns.sns_arn}"]
  ok_actions = ["${module.disha_sns.sns_arn}"]
  dimensions {
    InstanceId = "${aws_elasticache_cluster.redis_cluster.id}"
  }
}

//resource "aws_cloudwatch_metric_alarm" "elastic_redis_FreeableMemory" {
//  alarm_name = "${var.env}-elastic-redis-Low-FreeableMemory"
//  comparison_operator = "LessThanOrEqualToThreshold"
//  evaluation_periods = 1
//  metric_name = "FreeableMemory"
//  namespace = "AWS/ElastiCache"
//  period = 300
//  statistic = "Average"
//  threshold = 500000000
//  alarm_description = "This metric monitor FreeableMemory of redis"
//  alarm_actions = ["${module.disha_sns.sns_arn}"]
//  insufficient_data_actions = ["${module.disha_sns.sns_arn}"]
//  ok_actions = ["${module.disha_sns.sns_arn}"]
//  dimensions {
//    InstanceId = "${aws_elasticache_cluster.redis_cluster.id}"
//  }
//}