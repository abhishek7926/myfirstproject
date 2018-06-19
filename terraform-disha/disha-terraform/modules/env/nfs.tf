module "nfs_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.nfs_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "nfs"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="2049"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Platform-Core-Server"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"


}

module "nfs_volume_attach" {
  source                     = "../attach-copied-volume"
  snapshot_id ="${var.nfs_snapshot_id}"
  default_az="${var.default_az}"
  instance_id="${module.nfs_instance.instance_id}"
  device_name="/dev/sdh"
  volume_type="gp2"
  instance_name = "${module.nfs_instance.instance_name}"
}