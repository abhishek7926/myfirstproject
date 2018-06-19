resource "aws_autoscaling_policy" "increase-group-size" {
    name = "Increase group size"
    policy_type="StepScaling"
    adjustment_type = "ChangeInCapacity"
    autoscaling_group_name = "${var.as_name}"
    metric_aggregation_type = "Average"
    step_adjustment {
            scaling_adjustment = "${var.scale_up_by_instances}"
	    metric_interval_lower_bound=0
      }
    estimated_instance_warmup="${var.scale_up_warmup}"
}

resource "aws_autoscaling_policy" "decrease-group-size" {
    name = "Decrease group size"
    policy_type="StepScaling"
    adjustment_type = "ChangeInCapacity"
    autoscaling_group_name = "${var.as_name}"
    metric_aggregation_type = "Average"
    step_adjustment {
            scaling_adjustment = "${var.scale_down_by_instances}"
            metric_interval_upper_bound=0
}

}

resource "aws_cloudwatch_metric_alarm" "cpu-high" {
    alarm_name = "${format("%s", lower("${var.as_name}-CPU-HIGH"))}"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "${var.scale_up_consecutive_periods}"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "${var.scale_up_period}"
    statistic = "Average"
    threshold = "${var.cpu_high_threshold}"
    alarm_description = "This metric monitors cpu for high utilization of ${var.as_name}"
    alarm_actions = [
        "${aws_autoscaling_policy.increase-group-size.arn}"
    ]
    dimensions {
        AutoScalingGroupName = "${var.as_name}"
    }
}

resource "aws_cloudwatch_metric_alarm" "cpu-low" {
    alarm_name = "${format("%s", lower("${var.as_name}-CPU-low"))}"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "${var.scale_down_consecutive_periods}"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "${var.scale_down_period}"
    statistic = "Average"
    threshold = "${var.cpu_low_threshold}"
    alarm_description = "This metric monitors cpu for low utilization of ${var.as_name}"
    alarm_actions = [
        "${aws_autoscaling_policy.decrease-group-size.arn}"
    ]
    dimensions {
        AutoScalingGroupName ="${var.as_name}"
    }
}

