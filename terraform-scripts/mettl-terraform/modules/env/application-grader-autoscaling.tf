module "application-grader" {
  source                    = "../autoscaling"
  aws_region		    = "${var.aws_region}"
  instance_authorization_key="${module.vpc.auth_id}"
  as_name                   = "application-grader"
  sns_arn  ="${module.platform_sns.sns_arn}"

  private_dns_zone_name="${var.private_dns_zone_name}"
  env="${var.env}"
  lc_ami                        = "${lookup(var.application-grader,"lc_ami")}"
  lc_instance_type              = "${lookup(var.application-grader,"lc_instance_type")}"
  user_data                     = "../documents/userdata/autoscaling/application-grader-userdata"
  as_max_size                   = "${lookup(var.application-grader,"as_max_size")}"
  as_min_size                   = "${lookup(var.application-grader,"as_min_size")}"
  # as_desired_size               = "${lookup(var.application-grader,"as_desired_size")}"
  as_default_cooldown           = "${lookup(var.application-grader,"as_default_cooldown")}"
  health_check_grace_period     = "${lookup(var.application-grader,"health_check_grace_period")}"
  health_check_type             = "${lookup(var.application-grader,"health_check_type")}"
  iam_instance_profile = "${aws_iam_instance_profile.autoscaling-deployment-s3logs-iam-profile.id}"


  lc_sg                     = ["${aws_security_group.application_sg.id}"]
  as_subnet_id		    = "${module.vpc.application_subnet_id}"
  ag_instance_cluster_tag = "Platform"
  enable_monitoring="${var.enable_monitoring}"


  as_sns_arn = "${module.platform_as_sns.sns_arn}"

}


module "application-grader-scaling" {

  source="./../scaling-policies/queue"
  env = "${var.env}"
  as_name="${module.application-grader.as_name_output}"
  scale_up_consecutive_periods="${lookup(var.application-grader,"scale_up_consecutive_periods")}"
  scale_up_period="${lookup(var.application-grader,"scale_up_period")}"
  scale_down_consecutive_periods="${lookup(var.application-grader,"scale_down_consecutive_periods")}"
  scale_down_period="${lookup(var.application-grader,"scale_down_period")}"
  scale_down_by_instances = "${lookup(var.application-grader,"scale_down_by_instances")}"
  scale_up_by_instances = "${lookup(var.application-grader,"scale_up_by_instances")}"
  scale_up_cooldown = "${lookup(var.application-grader,"scale_up_cooldown")}"
  scale_down_cooldown = "${lookup(var.application-grader,"scale_down_cooldown")}"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"
  low_queue_size_threshold = "${lookup(var.application-grader,"low_queue_size_threshold")}"
  high_queue_size_threshold = "${lookup(var.application-grader,"high_queue_size_threshold")}"
  queue = "${lookup(var.application-grader,"queue")}"
}

