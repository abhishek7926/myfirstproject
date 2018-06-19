resource "aws_cloudwatch_metric_alarm" "tcp-monitoring" {
  count="${var.enable_monitoring == "0" ? 0 : length(var.tcp_services)}"
  alarm_name          = "${var.env}-${lookup(var.tcp_services[count.index],"name")} is unreachable at ${lookup(var.tcp_services[count.index],"port")}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Port_Response_check"
  namespace           ="${format("%s", lower("custom-ec2-${var.env}"))}"
  period              = "60"
  statistic           = "Average"
  threshold           = "1"

  dimensions {
    Port ="${lookup(var.tcp_services[count.index],"port")}"
    Url                   ="${format("%s", lower("${lookup(var.tcp_services[count.index],"name")}.${var.private_dns_zone_name}"))}"
    Tcp_monitoring="metric"
  }

  alarm_description = "This metric monitor check whether provided service is reachable or not."
  alarm_actions     =["${lookup(var.tcp_services[count.index],"sns")}"]
  insufficient_data_actions=["${lookup(var.tcp_services[count.index],"sns")}"]
  ok_actions=["${lookup(var.tcp_services[count.index],"sns")}"]
}