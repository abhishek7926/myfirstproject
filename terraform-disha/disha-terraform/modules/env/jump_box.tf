module "jump_box" {
  source                     = "../instance"
  instance_type              = "t2.micro"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "jump-box"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "0"
  sg_rule=[
    {
      type="ingress"
      port="22"
      protocol="tcp"
      cidr="0.0.0.0/0"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Maintenance"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"
  instance_iam_profile = ""

}