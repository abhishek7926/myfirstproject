module "wordpress_instance" {
  source                     = "../instance"
  instance_type              = "${var.wordpress_instance_type}"
  instance_ami_id            = "${var.wordpress_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "wordpress"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="443"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }
]
private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
private_dns_zone_name      = "${var.private_dns_zone_name}"
instance_cluster_tag = "Maintenance"
alarm_notification_arn = "${module.maintenance_sns.sns_arn}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
env                        = "${var.env}"
enable_monitoring          = "0"


}