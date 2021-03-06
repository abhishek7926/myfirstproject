resource "aws_elb" "elb-http" {
  name            = "${var.env}-${var.lb_name}-lb"
  subnets         = ["${var.elb_subnet}"]
  security_groups = ["${var.elb_sg_id}"]
  internal        = "${var.is_internal}"

  access_logs {
    bucket           = "${var.env}-elb-logs"
    bucket_prefix    = "${var.env}-${var.lb_name}"
    interval      = "${lookup(var.elb_logs,"elb_logs_interval")}"
    enabled       = "${lookup(var.elb_logs,"elb_logs_enabled")}"
  }

  listener {
    instance_port     = "${lookup(var.listener[0],"listener_instance_port")}"
    instance_protocol = "${lookup(var.listener[0],"listener_instance_protocol")}"
    lb_port           = "${lookup(var.listener[0],"listener_lb_port")}"
    lb_protocol       = "${lookup(var.listener[0],"listener_lb_protocol")}"


  }
  listener {
    instance_port     = "${lookup(var.listener[1],"listener_instance_port")}"
    instance_protocol = "${lookup(var.listener[1],"listener_instance_protocol")}"
    lb_port           = "${lookup(var.listener[1],"listener_lb_port")}"
    lb_protocol       = "${lookup(var.listener[1],"listener_lb_protocol")}"
    ssl_certificate_id = "${var.ssl_certificate_id}"
  }
  health_check {
    healthy_threshold   = "${lookup(var.health_check,"health_check_healthy_threshold")}"
    unhealthy_threshold = "${lookup(var.health_check,"health_check_unhealthy_threshold")}"
    timeout             = "${lookup(var.health_check,"health_check_response_timeout")}"
    target              = "${lookup(var.health_check,"health_check_target")}"
    interval            = "${lookup(var.health_check,"health_check_interval")}"
  }
  connection_draining  = "${lookup(var.elb_connection_draining,"set_connection_draining")}"
  connection_draining_timeout = "${lookup(var.elb_connection_draining,"connection_draining_timeout")}"

}

resource "aws_cloudwatch_metric_alarm" "high_unhealthy_alarm" {
  alarm_name          = "${var.env}-ELB-${var.lb_name}-High-Unhealthy-Hosts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ELB"
  period              = "60"
  statistic           = "Average"
  threshold           = "0"

  dimensions {
    LoadBalancerName = "${var.env}-${var.lb_name}"
  }

  alarm_description = "${format("Raises alarm if unhealthy instances in %s load balancer increase", "${var.env}-${var.lb_name}")}"
  alarm_actions     = ["${var.notification_sns_arn}"]
}

resource "aws_cloudwatch_metric_alarm" "low_healthy_alarm" {
  alarm_name          = "${var.env}-ELB-${var.lb_name}-Low-Healthy-Hosts"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ELB"
  period              = "60"
  statistic           = "Average"
  threshold           = "1"

  dimensions {
    LoadBalancerName = "${var.env}-${var.lb_name}"
  }

  alarm_description = "${format("Raises alarm if healthy instances in %s load balancer decrease", "${var.env}-${var.lb_name}")}"
  alarm_actions     = ["${var.notification_sns_arn}"]
}