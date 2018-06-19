module "report_instance" {
  source                     = "../instance-without-special-sg"
  instance_type              = "${var.report_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  common_sg              = "${aws_security_group.application_sg.id}"

  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "report"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"

  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Reporting"
  alarm_notification_arn = "${module.reporting_sns.sns_arn}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"


}


module "bulkpdf_instance" {
  source                     = "../instance-without-special-sg"
  instance_type              = "${var.bulkpdf_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  common_sg              = "${aws_security_group.application_sg.id}"

  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "bulkpdf"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"

  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Reporting"
  alarm_notification_arn = "${module.reporting_sns.sns_arn}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"

}



module "dblysis_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.dblysis_instance_type}"
  instance_name              = "dblysis"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="9013"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Simulators"
  alarm_notification_arn = "${module.simulators_sns.sns_arn}"

}

module "htmltopdf_instance" {
  source                     = "../instance-with-generic-userdata"
  instance_type              = "${var.htmltopdf_instance_type}"
  instance_ami_id            = "${var.aws_htmltopdf_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "htmltopdf"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8030"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  ansible_pub_key = "${var.ansible_pub_key}"
  instance_cluster_tag = "Reporting"
  alarm_notification_arn = "${module.reporting_sns.sns_arn}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  disk_paths                = "${var.htmltopdf_disk_paths}"
}

module "intellisense_instance" {
source                     = "../instance-with-generic-userdata"
instance_type              = "${var.intellisense_instance_type}"
instance_ami_id            = "${var.aws_intellisense_ami}"
instance_authorization_key = "${module.vpc.auth_id}"
instance_subnet_id         = "${module.vpc.application_subnet_id}"
instance_name              = "intellisense"
additional_sg		     = "${aws_security_group.application_sg.id}"
vpc_id                     = "${module.vpc.vpc_id}"
env                        = "${var.env}"
enable_monitoring          = "${var.enable_monitoring}"
sg_rule=[
{
type="ingress"
port="8001"
protocol="tcp"
cidr="${var.vpc_cidr}"
}

]
  disk_paths = "${var.intellisense_disk_paths}"
private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
private_dns_zone_name      = "${var.private_dns_zone_name}"
ansible_pub_key = "${var.ansible_pub_key}"
instance_cluster_tag = "Apps"
alarm_notification_arn = "${module.apps_sns.sns_arn}"
instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"

}


module "english_simulator_instance" {
source                     = "../instance-with-generic-userdata"
instance_type              = "${var.english_simulator_instance_type}"
instance_ami_id            = "${var.aws_english_simulator_ami}"
instance_authorization_key = "${module.vpc.auth_id}"
instance_subnet_id         = "${module.vpc.application_subnet_id}"
instance_name              = "english-simulator"
additional_sg		     = "${aws_security_group.application_sg.id}"
vpc_id                     = "${module.vpc.vpc_id}"
env                        = "${var.env}"
enable_monitoring          = "${var.enable_monitoring}"
sg_rule=[
{
type="ingress"
port="5000"
protocol="tcp"
cidr="${var.vpc_cidr}"
}

]
private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
private_dns_zone_name      = "${var.private_dns_zone_name}"
ansible_pub_key = "${var.ansible_pub_key}"
instance_cluster_tag = "Simulators"
alarm_notification_arn = "${module.simulators_sns.sns_arn}"
instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
disk_paths = "${var.english_simulator_disk_paths}"
}
/*
module "attach_trial" {
  source                     = "../attach-copied-volume"
  snapshot_id ="${var.htmltopdf_snapshot_id}"
  default_az="${var.default_az}"
  ebs_name="htmltopdf"
  instance_id="${module.htmltopdf_instance.instance_id}"
  device_name="/dev/sdh"

}
*/




module "excel_instance" {
  source                     = "../instance-without-special-sg"
  instance_type              = "${var.excel_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  common_sg              = "${aws_security_group.application_sg.id}"

  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "excel"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"

  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Reporting"
  alarm_notification_arn = "${module.reporting_sns.sns_arn}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"

}

module "large_excel_instance" {
source                     = "../instance-without-special-sg"
instance_type              = "${var.large_excel_instance_type}"
instance_ami_id            = "${var.aws_app_ami}"
common_sg              = "${aws_security_group.application_sg.id}"

instance_authorization_key = "${module.vpc.auth_id}"
instance_subnet_id         = "${module.vpc.application_subnet_id}"
instance_name              = "large-excel"
env                        = "${var.env}"
enable_monitoring          = "${var.enable_monitoring}"

private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
private_dns_zone_name      = "${var.private_dns_zone_name}"
instance_cluster_tag = "Reporting"
alarm_notification_arn = "${module.reporting_sns.sns_arn}"
instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"

}

module "scheduler_instance" {
  source                     = "../instance-without-special-sg"
  instance_type              = "${var.scheduler_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  common_sg              = "${aws_security_group.application_sg.id}"

  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "scheduler"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"

  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Platform"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"

}

module "typing_simulator_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.typingsimulator_instance_type}"
  instance_name              = "typing-simulator"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="9900"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Simulators"
  alarm_notification_arn = "${module.simulators_sns.sns_arn}"

}

module "schema_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.schema_instance_type}"
  instance_name              = "schema"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="9999"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Simulators"
  alarm_notification_arn = "${module.simulators_sns.sns_arn}"

}

module "proctoring_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.proctoring_instance_type}"
  instance_name              = "proctoring"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="${var.vpc_cidr}"},
    {
      type="ingress"
      port="443"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Proctoring"
  alarm_notification_arn = "${module.proctoring_sns.sns_arn}"

}


module "live_feed_router_instance" {
  source                     = "../instance-without-special-sg"
  instance_type              = "${var.live_feed_router_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  common_sg              = "${aws_security_group.application_sg.id},${aws_security_group.livefeed-hazelcast.id}"

  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "livefeed-router"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"

  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Proctoring"
  alarm_notification_arn = "${module.proctoring_sns.sns_arn}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"

}