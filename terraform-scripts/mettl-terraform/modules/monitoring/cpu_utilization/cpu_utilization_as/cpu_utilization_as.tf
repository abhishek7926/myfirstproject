resource "aws_cloudwatch_metric_alarm" "cpu_utilization_as" {
  count="${var.enable_monitoring}"
  alarm_name                = "${format("%s", lower("${var.as_name}-high-cpu-utilization"))}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "${lookup(var.monitoring_params,"evaluation_period")}"
  period ="${lookup(var.monitoring_params,"period")}"
  threshold = "${lookup(var.monitoring_params,"threshold")}"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  statistic                 = "Maximum"
  alarm_description         = "${format("%s",lower("This metric monitors aggregated cpu utilization for autoscaling group-${var.as_name}"))}"
  insufficient_data_actions=["${var.alarm_notification_arn}"]
  ok_actions=["${var.alarm_notification_arn}"]
  alarm_actions     =["${var.alarm_notification_arn}"]
  dimensions {
    AutoScalingGroupName = "${var.as_name}"
  }
}


