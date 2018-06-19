resource "aws_cloudwatch_metric_alarm" "swap_utilization_instance" {
  count="${var.enable_monitoring}"
  alarm_name                = "${format("%s", lower("${var.instance_name}-high-swap-utilization"))}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "SwapUtilization"
  namespace                 = "${format("%s", lower("custom-ec2-${var.env}"))}"
  evaluation_periods = "${lookup(var.monitoring_params,"evaluation_period")}"
  period ="${lookup(var.monitoring_params,"period")}"
  threshold = "${lookup(var.monitoring_params,"threshold")}"
  statistic                 = "Average"
  alarm_description         = "${format("%s",lower("This metric monitors swap utilization for instance-${var.instance_name}"))}"
  insufficient_data_actions=["${var.alarm_notification_arn}"]
  ok_actions=["${var.alarm_notification_arn}"]
  alarm_actions     =["${var.alarm_notification_arn}"]

  dimensions {
    InstanceId = "${var.instance_id}"
  }}


