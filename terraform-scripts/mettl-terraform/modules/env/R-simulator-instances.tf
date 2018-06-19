module "r_simulators_router_instance" {
  source                     = "../instance"
  instance_type              = "${var.r_simulators_router_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "r-simulators-router"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Simulators"
  alarm_notification_arn = "${module.simulators_sns.sns_arn}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  additional_sg		     = "${aws_security_group.application_sg.id},${aws_security_group.r-simulator-hazelcast.id}"
  sg_rule=[
    {
      type="ingress"
      port="10001"
      protocol="tcp"
      cidr="${var.vpc_cidr}"}
  ]
  vpc_id = "${module.vpc.vpc_id}"
}