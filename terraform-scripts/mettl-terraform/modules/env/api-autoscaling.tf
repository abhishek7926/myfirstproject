module "mettl-api" {
  source = "./../autoscaling-with-lb-http-listener"
  aws_region="${var.aws_region}"
  lc_ami                        = "${lookup(var.mettl-api,"lc_ami")}"
  lc_instance_type              = "${lookup(var.mettl-api,"lc_instance_type")}"
  user_data                     = "../documents/userdata/autoscaling/mettl-api-userdata"
  as_max_size                   = "${lookup(var.mettl-api,"as_max_size")}"
  as_min_size                   = "${lookup(var.mettl-api,"as_min_size")}"
  # as_desired_size               = "${lookup(var.mettl-api,"as_desired_size")}"
  as_default_cooldown           = "${lookup(var.mettl-api,"as_default_cooldown")}"
  health_check_grace_period     = "${lookup(var.mettl-api,"health_check_grace_period")}"
  health_check_type             = "${lookup(var.mettl-api,"health_check_type")}"
  iam_instance_profile = "${aws_iam_instance_profile.autoscaling-deployment-s3logs-iam-profile.id}"
  #elb_logs_bucket=""  # instead of variable use env and rest hardcode
  #elb_logs_folder=""
  private_dns_zone_name="${var.private_dns_zone_name}"
  env="${var.env}"
  instance_authorization_key       = "${module.vpc.auth_id}"
  as_subnet_id                     = "${module.vpc.application_subnet_id}"
  lc_sg                            = ["${aws_security_group.application_sg.id}","${module.elb-http-sg.sg_id}"]
  as_name                          = "mettl-api"
  elb_subnet                       = "${module.vpc.public_subnet_id}"
  elb_sg_id                        = "${module.elb-http-sg.sg_id}"
  elb_idle_timeout                 = "360"
  ssl_certificate_id               = "${var.acm_certificate_arn }"



  health_check={
    health_check_healthy_threshold   = "2"
    health_check_unhealthy_threshold = "2"
    health_check_target              = "HTTP:80/v1/health"
    health_check_response_timeout = "9"
    health_check_interval         = "10"
  }


  elb_logs = {
    elb_logs_interval = "60"
    elb_logs_enabled = "true"

  }

  elb_connection_draining = {
    set_connection_draining=true
    connection_draining_timeout="300"
  }

  ag_instance_cluster_tag = "Platform"
  notification_sns_arn  ="${module.platform_sns.sns_arn}"
  enable_monitoring="${var.enable_monitoring}"
  as_notification_sns_arn = "${module.platform_as_sns.sns_arn}"
}


