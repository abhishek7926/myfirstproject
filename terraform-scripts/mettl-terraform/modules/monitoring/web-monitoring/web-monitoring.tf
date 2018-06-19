resource "aws_cloudwatch_metric_alarm" "web-monitoring" {
  count="${var.enable_monitoring == "0" ? 0 : length(var.web_urls)}"
  alarm_name          = "${format("%s", lower("${lookup(var.web_urls[count.index],"pre_dns")}${var.public_dns_zone_name}${lookup(var.web_urls[count.index],"post_dns")} is down"))}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Website_Response_check"
  namespace           ="${format("%s", lower("custom-ec2-${var.env}"))}"
  period              = "60"
  statistic           = "Average"
  threshold           = "1"

  dimensions {
    Desired_response_code ="${lookup(var.web_urls[count.index],"response_code")}"
    Url                   ="${format("%s", "${lookup(var.web_urls[count.index],"pre_dns")}${var.public_dns_zone_name}${lookup(var.web_urls[count.index],"post_dns")}")}"
    Web_monitoring="metric"
  }

  alarm_description = "This metric monitor check whether provided site is up or not."
  alarm_actions     =["${lookup(var.web_urls[count.index],"sns")}"]
  insufficient_data_actions=["${lookup(var.web_urls[count.index],"sns")}"]
  ok_actions=["${lookup(var.web_urls[count.index],"sns")}"]
}
  
