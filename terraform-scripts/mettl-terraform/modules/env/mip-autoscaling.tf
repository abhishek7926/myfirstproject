module "mip" {
  source                    = "../autoscaling"
  aws_region		    = "${var.aws_region}"
  instance_authorization_key="${module.vpc.auth_id}"
  as_name                   = "MIP"
  private_dns_zone_name="${var.private_dns_zone_name}"
  sns_arn  ="${module.proctoring_sns.sns_arn}"
  as_sns_arn = "${module.proctoring_as_sns.sns_arn}"


  env="${var.env}"
  lc_ami                        = "${lookup(var.mip,"lc_ami")}"
  lc_instance_type              = "${lookup(var.mip,"lc_instance_type")}"
  user_data                     = "../documents/userdata/autoscaling/mip-userdata"
  as_max_size                   = "${lookup(var.mip,"as_max_size")}"
  as_min_size                   = "${lookup(var.mip,"as_min_size")}"
  #as_desired_size               = "${lookup(var.mip,"as_desired_size")}"
  as_default_cooldown           = "${lookup(var.mip,"as_default_cooldown")}"
  health_check_grace_period     = "${lookup(var.mip,"health_check_grace_period")}"
  health_check_type             = "${lookup(var.mip,"health_check_type")}"

  iam_instance_profile = "${aws_iam_instance_profile.autoscaling-deployment-s3logs-iam-profile.id}"

  lc_sg                     = ["${aws_security_group.application_sg.id}"]
  as_subnet_id		    = "${module.vpc.application_subnet_id}"
  ag_instance_cluster_tag = "Proctoring"
  enable_monitoring="0"
  #  as_enabled_metrics=["GroupMinSize"]
  #  depends_on = ["module.uc_elb"]
  disk_paths           =  [

    {
      Filesystem="/dev/xvda1"
      MountPath="/"
    }



  ]
}

module "mip-event-scaling" {

  source="./../scaling-policies/queue"
  env = "${var.env}"
  as_name="${module.mip.as_name_output}"
  scale_up_consecutive_periods="${lookup(var.mip,"scale_up_consecutive_periods")}"
  scale_up_period="${lookup(var.mip,"scale_up_period")}"
  scale_down_consecutive_periods="${lookup(var.mip,"scale_down_consecutive_periods")}"
  scale_down_period="${lookup(var.mip,"scale_down_period")}"
  scale_down_by_instances = "${lookup(var.mip,"scale_down_by_instances")}"
  scale_up_by_instances = "${lookup(var.mip,"scale_up_by_instances")}"
  scale_up_cooldown = "${lookup(var.mip,"scale_up_cooldown")}"
  scale_down_cooldown = "${lookup(var.mip,"scale_down_cooldown")}"
  alarm_notification_arn = "${module.proctoring_sns.sns_arn}"
  low_queue_size_threshold = "${lookup(var.mip,"low_queue_size_threshold")}"
  high_queue_size_threshold = "${lookup(var.mip,"high_queue_size_threshold")}"
  queue = "${lookup(var.mip,"queue")}"
}

