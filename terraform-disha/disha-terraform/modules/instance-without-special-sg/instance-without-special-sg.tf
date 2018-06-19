resource "aws_instance" "instance-without-special-sg" {
  instance_type          = "${var.instance_type}"
  ami                    = "${var.instance_ami_id}"
  key_name               = "${var.instance_authorization_key}"
  vpc_security_group_ids = ["${compact(split(",", var.common_sg))}"]
  subnet_id              = "${var.instance_subnet_id}"
  tags {
    Name        = "${var.env}-${var.instance_name}",
    Environment = "${format("%s", lower("${var.env}"))}",
    Cluster     = "${format("%s", lower("${var.instance_cluster_tag}"))}"
  }
  iam_instance_profile = "${var.instance_iam_profile}"
  volume_tags {
    Name = "${var.env}-${var.instance_name}"
  }
}

resource "aws_route53_record" "instance_route53_entry" {
  zone_id    =  "${var.private_route53_zone_id}"
  name       = "${format("%s", lower("${var.instance_name}"))}"
  type       = "A"
  ttl        = "60"
  records    = ["${aws_instance.instance-without-special-sg.private_ip}"]
}
resource "aws_cloudwatch_metric_alarm" "instance_status_check" {
  alarm_name          = "${var.env}-${var.instance_name}-status-checks-failed"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "1"
  alarm_description = "This metric monitors ec2 status checks"
  alarm_actions     =["${var.alarm_notification_arn}"]
  insufficient_data_actions=["${var.alarm_notification_arn}"]
  ok_actions=["${var.alarm_notification_arn}"]
  dimensions {
    InstanceId = "${aws_instance.instance-without-special-sg.id}"
  }
}