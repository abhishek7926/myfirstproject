resource "aws_alb_target_group" "alb_tg" {
  name                  = "${var.env}-${var.alb_tg_name}"
  port                  = "${var.alb_tg_port}"
  protocol              = "${var.alb_tg_protocol}"
  vpc_id                = "${var.alb_tg_vpc_id}"

  health_check {
    protocol            = "${lookup(var.health_check,"health_check_protocol")}"
    path                = "${lookup(var.health_check,"health_check_path")}"
    port                = "${lookup(var.health_check,"health_check_port")}"
    healthy_threshold   = "${lookup(var.health_check,"health_check_healthy_threshold")}"
    unhealthy_threshold = "${lookup(var.health_check,"health_check_unhealthy_threshold")}"
    timeout             = "${lookup(var.health_check,"health_check_response_timeout")}"
    interval            = "${lookup(var.health_check,"health_check_interval")}"
    matcher             = "${lookup(var.health_check,"health_check_success_codes")}"

  }

}

resource "aws_cloudwatch_metric_alarm" "high_unhealthy_alarm" {
  alarm_name            = "${var.env}-ELB-${var.alb_tg_name}-High-Unhealthy-Hosts"
  comparison_operator   = "GreaterThanThreshold"
  evaluation_periods    = "1"
  metric_name           = "UnHealthyHostCount"
  namespace             = "AWS/ELB"
  period                = "60"
  statistic             = "Average"
  threshold             = "0"

  dimensions {
    LoadBalancerName    = "${var.env}-${var.alb_tg_name}"
  }

  alarm_description     = "${format("Raises alarm if unhealthy instances in %s load balancer increase", "${var.env}-${var.alb_tg_name}")}"
  alarm_actions         = ["${var.notification_sns_arn}"]
}

resource "aws_cloudwatch_metric_alarm" "low_healthy_alarm" {
  alarm_name            = "${var.env}-ELB-${var.alb_tg_name}-Low-Healthy-Hosts"
  comparison_operator   = "LessThanThreshold"
  evaluation_periods    = "1"
  metric_name           = "HealthyHostCount"
  namespace             = "AWS/ELB"
  period                = "60"
  statistic             = "Average"
  threshold             = "1"

  dimensions {
    LoadBalancerName    = "${var.env}-${var.alb_tg_name}"
  }

  alarm_description     = "${format("Raises alarm if healthy instances in %s load balancer decrease", "${var.env}-${var.alb_tg_name}")}"
  alarm_actions         = ["${var.notification_sns_arn}"]
}