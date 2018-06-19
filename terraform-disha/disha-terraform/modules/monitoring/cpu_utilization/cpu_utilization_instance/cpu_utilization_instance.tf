resource "aws_cloudwatch_metric_alarm" "cpu_utilization_instance" {
  count="${var.enable_monitoring}"
  alarm_name                = "${format("%s", lower("${var.instance_name}-high-cpu-utilization"))}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "${lookup(var.monitoring_params,"evaluation_period")}"
  period ="${lookup(var.monitoring_params,"period")}"
  threshold = "${lookup(var.monitoring_params,"threshold")}"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  statistic                 = "Average"
  alarm_description         = "${format("%s",lower("This metric monitors  cpu utilization for instance-${var.instance_name}"))}"
insufficient_data_actions=["${var.alarm_notification_arn}"]
  ok_actions=["${var.alarm_notification_arn}"]
  alarm_actions     =["${var.alarm_notification_arn}"]

  dimensions {
    InstanceId = "${var.instance_id}"
  }}


