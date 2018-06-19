resource "aws_cloudwatch_metric_alarm" "disk_utilization_as" {
  count="${var.enable_monitoring == "0" ? 0 : length(var.disk_paths)}"
  alarm_name                = "${format("%s", lower("${var.as_name}-high-disk-utilization-for-${lookup(var.disk_paths[count.index],"MountPath")}"))}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  threshold = "${lookup(var.monitoring_params,"threshold")}"
  period ="${lookup(var.monitoring_params,"period")}"
  evaluation_periods = "${lookup(var.monitoring_params,"evaluation_period")}"
  metric_name               = "DiskUsage"
  namespace                 = "${format("%s", lower("custom-ec2-${var.env}"))}"
  statistic                 = "Maximum"
  alarm_description         = "${format("%s",lower("This metric monitors aggregated disk utilization for autoscaling group-${var.as_name} for mount path ${lookup(var.disk_paths[count.index],"MountPath")}"))}"
  insufficient_data_actions=["${var.alarm_notification_arn}"]
  ok_actions=["${var.alarm_notification_arn}"]
  alarm_actions     =["${var.alarm_notification_arn}"]

  dimensions {
    AutoScalingGroupName = "${var.as_name}"
    Device="${lookup(var.disk_paths[count.index],"Filesystem")}"
    MountPath="${lookup(var.disk_paths[count.index],"MountPath")}"
    DiskUsage="metric"
  }}


