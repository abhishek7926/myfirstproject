resource "aws_instance" "instance-with-generic-userdata" {
  instance_type          = "${var.instance_type}"
  ami                    = "${var.instance_ami_id}"
  key_name               = "${var.instance_authorization_key}"
  vpc_security_group_ids = ["${var.additional_sg}","${module.sg.sg_id}"]
  subnet_id              = "${var.instance_subnet_id}"
  user_data         =  "${data.template_file.generic_userdata_as_template.rendered}"
  iam_instance_profile = "${var.instance_iam_profile}"
  tags {
    Name        = "${format("%s", lower("${var.instance_name}.${var.private_dns_zone_name}"))}",
    Environment = "${format("%s", lower("${var.private_dns_zone_name}"))}",
    Cluster     = "${format("%s", lower("${var.instance_cluster_tag}"))}"
  }
  volume_tags {
    Name = "${format("%s", lower("${var.instance_name}.${var.private_dns_zone_name}"))}"
  }
}
data "template_file" "generic_userdata_as_template" {
  template = "${file("../generic-ami-userdata")}"
  vars {
    ansible_public_key = "${var.ansible_pub_key}"
  }
}
module "sg" {
  source            = "./../sg"
  sg_name           = "${format("%s", lower("${var.instance_name}-sg.${var.private_dns_zone_name}"))}"
  sg_vpc_id         = "${var.vpc_id}"
  sg_rule           = "${var.sg_rule}"
}

resource "aws_route53_record" "instance_route53_entry" {
  zone_id    = "${var.private_route53_zone_id}"
  name       = "${format("%s", lower("${var.instance_name}"))}"
  type       = "A"
  ttl        = "60"
  records    = ["${aws_instance.instance-with-generic-userdata.private_ip}"]
}
resource "aws_cloudwatch_metric_alarm" "instance_status_check" {
  alarm_name          = "${format("%s", lower("${var.instance_name}-status-checks-failed-${var.private_dns_zone_name}"))}"
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
    InstanceId = "${aws_instance.instance-with-generic-userdata.id}"
  }
}
