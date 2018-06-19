resource "aws_cloudwatch_metric_alarm" "service-monitoring" {
  count="${var.enable_monitoring == "0" ? 0 : length(var.autoscaling_services_to_monitor)}"
  alarm_name          = "${format("%s", lower("${lookup(var.autoscaling_services_to_monitor[count.index],"name")}.${var.private_dns_zone_name} is down"))}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "ServiceProcess"
  namespace           ="${format("%s", lower("custom-ec2-${var.env}"))}"
  period              = "60"
  statistic           = "Average"
  threshold           = "1"

  dimensions {
    AutoScalingGroupName ="${format("%s", lower("${lookup(var.autoscaling_services_to_monitor[count.index],"name")}.${var.private_dns_zone_name}"))}"
    ServiceProcess         = "metric"
  }

  alarm_description = "This metric monitor check whether provided service is reachable or not."
  alarm_actions     =["${lookup(var.autoscaling_services_to_monitor[count.index],"sns")}"]
  insufficient_data_actions=["${lookup(var.autoscaling_services_to_monitor[count.index],"sns")}"]
  ok_actions=["${lookup(var.autoscaling_services_to_monitor[count.index],"sns")}"]
}