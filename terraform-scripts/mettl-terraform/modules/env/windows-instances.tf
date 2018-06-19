

module "windows_codelysis_instance" {
  source                     = "../windows-instance"
  instance_type              = "${var.windows_codelysis_instance_type}"
  instance_ami_id            = "${var.aws_windows_codelysis_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "windows-codelysis"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  instance_ebs_optimized = "false"

  sg_rule=[
    {
      type="ingress"
      port="9012"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="3389"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="1521"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="3306"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }


  ]
  instance_user="${var.windows_codelysis_instance_user}"
instance_password="${var.windows_codelysis_instance_password}"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Simulators"
  alarm_notification_arn = "${module.simulators_sns.sns_arn}"

}



module "windows_codeproject_instance" {
  source                     = "../windows-instance"
  instance_type              = "${var.windows_codeproject_instance_type}"
  instance_ami_id            = "${var.aws_windows_codeproject_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "windows-codeproject"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  sg_rule=[
    {
      type="ingress"
      port="1433"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="9411"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="3389"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }






  ]
  instance_ebs_optimized = "${var.windows_codeproject_instance_ebs_optimized}"
  instance_user="${var.windows_codeproject_instance_user}"
  instance_password="${var.windows_codeproject_instance_password}"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Simulators"
alarm_notification_arn = "${module.simulators_sns.sns_arn}"
}



