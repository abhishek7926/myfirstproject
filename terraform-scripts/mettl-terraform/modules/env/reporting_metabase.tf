module "reporting_metabase_instance" {
  source                     = "../instance"
  instance_count = "${var.reporting_metabase_count}"
  instance_type              = "${var.reporting_metabase_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "reporting_metabase"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Reporting"
  alarm_notification_arn = "${module.reporting_sns.sns_arn}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  sg_rule=[
  {
    type = "ingress"
    port = "80"
    protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  ]
  vpc_id = "${module.vpc.vpc_id}"
}