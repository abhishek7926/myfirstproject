resource "aws_autoscaling_policy" "increase-group-size" {
    name = "Increase group size"
    adjustment_type = "ChangeInCapacity"
    autoscaling_group_name = "${var.as_name}"
    scaling_adjustment="${var.scale_up_by_instances}"

    cooldown="${var.scale_up_cooldown}"
}

resource "aws_autoscaling_policy" "decrease-group-size" {
    name = "Decrease group size"
    adjustment_type = "ChangeInCapacity"
    autoscaling_group_name = "${var.as_name}"
    scaling_adjustment="${var.scale_down_by_instances}"
    cooldown="${var.scale_down_cooldown}"


}

resource "aws_cloudwatch_metric_alarm" "queue-high-average-pending-messages" {
    alarm_name = "${format("%s", lower("${var.as_name}-queue-high-average-pending-messages-for-autoscaling"))}"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "${var.scale_up_consecutive_periods}"
    metric_name = "AveragePendingMessages"
    namespace = "${format("%s", lower("custom-ec2-${var.env}"))}"
    period = "${var.scale_up_period}"
    statistic = "Average"
    threshold = "${var.high_queue_size_threshold}"
    alarm_description = "This metric monitors for high average pending messages of ${var.queue}"
    alarm_actions = [
        "${aws_autoscaling_policy.increase-group-size.arn}"
    ]
    dimensions {
        QueueName="${var.queue}",
        AveragePendingMessages="metric"
    }
}

resource "aws_cloudwatch_metric_alarm" "queue-low-average-pending-messages" {
    alarm_name = "${format("%s", lower("${var.as_name}-queue-low-average-pending-messages-for-autoscaling"))}"
    comparison_operator = "LessThanThreshold"
    evaluation_periods = "${var.scale_down_consecutive_periods}"
    metric_name = "AveragePendingMessages"
    namespace = "${format("%s", lower("custom-ec2-${var.env}"))}"
    period = "${var.scale_down_period}"
    statistic = "Average"
    threshold = "${var.low_queue_size_threshold}"
    alarm_description = "This metric monitors for high average pending messages of ${var.queue}"
    alarm_actions = [
        "${aws_autoscaling_policy.decrease-group-size.arn}"
    ]
    dimensions {
        QueueName="${var.queue}",
        AveragePendingMessages="metric"
    }
}



