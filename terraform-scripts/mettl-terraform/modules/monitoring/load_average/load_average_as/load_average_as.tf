resource "aws_cloudwatch_metric_alarm" "load_average_as" {
  count="${var.enable_monitoring}"
  alarm_name                = "${format("%s", lower("${var.as_name}-high-load-average"))}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  threshold = "${lookup(var.monitoring_params,"threshold")}"
  period ="${lookup(var.monitoring_params,"period")}"
  evaluation_periods = "${lookup(var.monitoring_params,"evaluation_period")}"
  metric_name               = "LoadAverage"
  namespace                 = "${format("%s", lower("custom-ec2-${var.env}"))}"
  statistic                 = "Maximum"
  alarm_description         = "${format("%s",lower("This metric monitors aggregated load average for autoscaling group-${var.as_name}"))}"
  insufficient_data_actions=["${var.alarm_notification_arn}"]
  alarm_actions     =["${var.alarm_notification_arn}"]

  ok_actions=["${var.alarm_notification_arn}"]
  dimensions {
    AutoScalingGroupName = "${var.as_name}"
    LoadAverage="metric"

  }}


