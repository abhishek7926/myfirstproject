module "as-with-lb-tcp" {
  source                    = "../autoscaling"
  aws_region		    = "${var.aws_region}"
  instance_authorization_key="${var.instance_authorization_key}"
  as_name                   = "${var.as_name}"
  lc_ami                    = "${var.lc_ami}"
  lc_instance_type          = "${var.lc_instance_type}"
  lc_sg                     = "${var.lc_sg}"
  as_elb_name               = ["${module.as-lb-tcp.elb_name_output}"]
  user_data                 = "${var.user_data}"
  as_max_size               = "${var.as_max_size}"
  as_min_size               = "${var.as_min_size}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  #as_desired_size           = "${var.as_desired_size}"
  as_default_cooldown       = "${var.as_default_cooldown}"
  as_subnet_id		    = "${var.as_subnet_id}"
  private_dns_zone_name="${var.private_dns_zone_name}"
  env = "${var.env}"
  iam_instance_profile = "${var.iam_instance_profile}"
  ag_instance_cluster_tag = "${var.ag_instance_cluster_tag}"
  ansible_public_key="${var.ansible_public_key}"
  sns_arn = "${var.notification_sns_arn}"
  enable_monitoring="${var.enable_monitoring}"
  disk_paths="${var.disk_paths}"
//  #  as_enabled_metrics=["GroupMinSize"]
//  #  depends_on = ["module.uc_elb"]
  as_sns_arn = "${var.as_notification_sns_arn}"
  lc_ebs = "${var.lc_ebs}"

}

module "as-lb-tcp" {
  source                           = "../lb-tcp"
  lb_name                          = "${var.as_name}"
  elb_subnet                       = "${var.elb_subnet}"
  elb_sg_id                        = "${var.elb_sg_id}"
  health_check   = "${var.health_check}"
  listener="${var.listener}"
  private_dns_zone_name="${var.private_dns_zone_name}"
  elb_idle_timeout                = "${var.elb_idle_timeout}"
  elb_connection_draining         = "${var.elb_connection_draining}"
  elb_logs = "${var.elb_logs}"
  notification_sns_arn="${var.notification_sns_arn}"

}
