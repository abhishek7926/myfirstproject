module "reporting_migrator_instance" {
  source                     = "../instance-without-special-sg"
  instance_without_sg_count = "${var.reporting_migrator_count}"
  instance_type              = "${var.reporting_migrator_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  common_sg              = "${aws_security_group.application_sg.id}"

  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "reporting_migrator"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"

  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Reporting"
  alarm_notification_arn = "${module.reporting_sns.sns_arn}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"

}