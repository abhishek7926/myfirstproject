module "elk_instance" {
  source                     = "../instance"
  instance_type              = "${var.elk_instance_type}"
  instance_ami_id            = "${var.aws_maintenance_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.maintenance_subnet_id}"
  instance_name              = "elk"
  additional_sg              = "${module.vpc.default_sg_id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  disk_paths                 = "${var.maintenance_ami_disk_paths}"
  sg_rule=[
    {
      type="ingress"
      port="5601"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Maintenance"
  alarm_notification_arn = "${module.maintenance_sns.sns_arn}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"

}
#############################################################################

module "kafka_instance" {
  source                     = "../instance"
  instance_type              = "${var.kafka_instance_type}"
  instance_ami_id            = "${var.aws_maintenance_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.maintenance_subnet_id}"
  instance_name              = "kafka"
  additional_sg              = "${module.vpc.default_sg_id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  disk_paths                 = "${var.maintenance_ami_disk_paths}"
  sg_rule=[
    {
      type="ingress"
      port="9092"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Maintenance"
  alarm_notification_arn = "${module.maintenance_sns.sns_arn}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"

}
###########################################################################################
module "zabbix_instance" {
  source                     = "../instance"
  instance_type              = "${var.zabbix_instance_type}"
  instance_ami_id            = "${var.aws_maintenance_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.maintenance_subnet_id}"
  instance_name              = "zabbix"
  additional_sg              = "${module.vpc.default_sg_id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  disk_paths                 = "${var.maintenance_ami_disk_paths}"
  sg_rule=[

    {
      type="ingress"
      port="10051"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }


  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Maintenance"
  alarm_notification_arn = "${module.maintenance_sns.sns_arn}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"

}
#################################################################################################


module "metric_publishing_instance" {
  # count="${ length(var.web_urls_to_monitor)}"
  source                     = "../instance-without-special-sg"
  instance_iam_profile = "${aws_iam_instance_profile.metrics-profile.id}"
  instance_type              = "${var.metric_publishing_instance_type}"
  instance_ami_id            = "${var.aws_maintenance_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "metrics"
  common_sg		     = "${aws_security_group.application_sg.id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  disk_paths                 = "${var.maintenance_ami_disk_paths}"

  instance_cluster_tag = "Maintenance"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.maintenance_sns.sns_arn}"

}
