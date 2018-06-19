resource "aws_cloudwatch_metric_alarm" "queue-low-consumers-for-at-least-one-consumer-queues" {
  count="${var.enable_monitoring == "0" ? 0 : length(var.queues_with_at_least_one_consumer)}"
  alarm_name                = "${format("%s", lower("${lookup(var.queues_with_at_least_one_consumer[count.index],"queue-name")}-low-consumers-alarm-on-${var.private_dns_zone_name}"))}"
  comparison_operator       = "LessThanThreshold"
  threshold = "1"
  period ="${lookup(var.monitoring_params,"period")}"
  evaluation_periods = "${lookup(var.monitoring_params,"evaluation_period")}"
  metric_name               = "Consumers"
  namespace                 = "${format("%s", lower("custom-ec2-${var.env}"))}"
  statistic                 = "Average"
  alarm_description         = "${format("%s",lower("This metric monitors consumers for queue ${lookup(var.queues_with_at_least_one_consumer[count.index],"queue-name")}"))}"
  insufficient_data_actions=["${lookup(var.queue_notification,"${lookup(var.queues_with_at_least_one_consumer[count.index],"queue-name")}")}"]
  ok_actions=["${lookup(var.queue_notification,"${lookup(var.queues_with_at_least_one_consumer[count.index],"queue-name")}")}"]
  alarm_actions     =["${lookup(var.queue_notification,"${lookup(var.queues_with_at_least_one_consumer[count.index],"queue-name")}")}"]

  dimensions {
    QueueName="${lookup(var.queues_with_at_least_one_consumer[count.index],"queue-name")}",
    Consumers="metric"
  }}

resource "aws_cloudwatch_metric_alarm" "queue-high-queue-size-for-at-least-one-consumer-queues" {
  count="${var.enable_monitoring == "0" ? 0 : length(var.queues_with_at_least_one_consumer)}"
  alarm_name                = "${format("%s", lower("${lookup(var.queues_with_at_least_one_consumer[count.index],"queue-name")}-high-queue-size-alarm-on-${var.private_dns_zone_name}"))}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  threshold = "${lookup(var.queues_with_at_least_one_consumer[count.index],"queue_size_threshold")}"
  period ="${lookup(var.monitoring_params,"period")}"
  evaluation_periods = "${lookup(var.monitoring_params,"evaluation_period")}"
  metric_name               = "QueueSize"
  namespace                 = "${format("%s", lower("custom-ec2-${var.env}"))}"
  statistic                 = "Minimum"
  alarm_description         = "${format("%s",lower("This metric monitors queue size for queue ${lookup(var.queues_with_at_least_one_consumer[count.index],"queue-name")}"))}"
  insufficient_data_actions=["${lookup(var.queue_notification,"${lookup(var.queues_with_at_least_one_consumer[count.index],"queue-name")}")}"]
  ok_actions=["${lookup(var.queue_notification,"${lookup(var.queues_with_at_least_one_consumer[count.index],"queue-name")}")}"]
  alarm_actions     =["${lookup(var.queue_notification,"${lookup(var.queues_with_at_least_one_consumer[count.index],"queue-name")}")}"]

  dimensions {
    QueueName="${lookup(var.queues_with_at_least_one_consumer[count.index],"queue-name")}",
    QueueSize="metric"
  }
}
