resource "aws_instance" "openvpn-instance" {
  instance_type = "${var.openvpn_instance_type}"
  ami = "${var.aws_maintenance_ami}"
  key_name = "${module.vpc.auth_id}"
  vpc_security_group_ids = ["${module.vpc.default_sg_id}","${aws_security_group.openvpn_sg.id}"]
  subnet_id = "${module.vpc.public_subnet_id}"
  user_data = "${file("../documents/userdata/standalone/openvpn-userdata")}"
  tags {
    Name ="${format("%s", lower("openvpn.${var.private_dns_zone_name}"))}",
    Environment = "${format("%s", lower("${var.private_dns_zone_name}"))}",
    Cluster     = "${format("%s", lower("${var.instance_cluster_tag}"))}"
  }
}

resource "aws_security_group" "openvpn_sg" {

  name        = "${format("%s", lower("openvpn-sg.${var.private_dns_zone_name}"))}"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress{
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port   = 943
    to_port     = 943
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_route53_record" "openvpn_dns" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name = "${format("%s", lower("openvpn.${var.private_dns_zone_name}"))}"
  type = "A"
  ttl = "60"
  records = ["${aws_instance.openvpn-instance.private_ip}"]
}



resource "aws_cloudwatch_metric_alarm" "openvpn_instance_status_check" {
  alarm_name          = "${format("%s", lower("openvpn.${var.private_dns_zone_name}-status-checks-failed"))}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "1"
  alarm_description = "This metric monitors ec2 status checks"
  alarm_actions     =["${module.maintenance_sns.sns_arn}"]
  insufficient_data_actions=["${module.maintenance_sns.sns_arn}"]
  ok_actions=["${module.maintenance_sns.sns_arn}"]
  dimensions {
    InstanceId = "${aws_instance.openvpn-instance.id}"
  }
}

module "openvpn_instance-disk-utilization" {
  source = "../monitoring/disk_utilization/disk_utilization_instance"
  enable_monitoring="0"
  disk_paths = "${var.maintenance_ami_disk_paths}"
  monitoring_params = {
    threshold = 80
    period = 60
    evaluation_period = 1
  }
  alarm_notification_arn = "${module.maintenance_sns.sns_arn}"
  instance_id = "${aws_instance.openvpn-instance.id}"
  instance_name = "${aws_instance.openvpn-instance.tags.Name}"
  env = "${var.env}"
}
module "openvpn_instance-inode-utilization" {
  source = "../monitoring/inodes/inodes_instance"
  enable_monitoring="0"
  disk_paths = "${var.maintenance_ami_disk_paths}"
  monitoring_params = {
    threshold = 80
    period = 60
    evaluation_period = 1
  }
  alarm_notification_arn = "${module.maintenance_sns.sns_arn}"
  instance_id = "${aws_instance.openvpn-instance.id}"
  instance_name = "${aws_instance.openvpn-instance.tags.Name}"
  env = "${var.env}"
}
//module "openvpn_instance-load-average" {
//  source = "../monitoring/load_average/load_average_instance"
//  enable_monitoring="0"
//  monitoring_params = {
//    threshold = 0.8
//    period = 60
//    evaluation_period = 1
//  }
//  instance_id = "${aws_instance.openvpn-instance.id}"
//  instance_name = "${aws_instance.openvpn-instance.tags.Name}"
//  alarm_notification_arn = "${module.maintenance_sns.sns_arn}"
//  env = "${var.env}"
//}
module "openvpn_instance-memory" {
  source = "../monitoring/memory_utilization/memory_utilization_instance"
  enable_monitoring="0"
  monitoring_params = {
    threshold = 80
    period = 60
    evaluation_period = 1
  }
  instance_id = "${aws_instance.openvpn-instance.id}"
  instance_name = "${aws_instance.openvpn-instance.tags.Name}"
  alarm_notification_arn = "${module.maintenance_sns.sns_arn}"
  env = "${var.env}"
}

module "openvpn_instance-swap" {
  source = "../monitoring/swap_utilization/swap_utilization_instance"
  enable_monitoring="0"
    monitoring_params = {
    threshold = 80
    period = 60
    evaluation_period = 1
  }
  instance_id = "${aws_instance.openvpn-instance.id}"
  instance_name = "${aws_instance.openvpn-instance.tags.Name}"
  alarm_notification_arn = "${module.maintenance_sns.sns_arn}"
  env = "${var.env}"
}