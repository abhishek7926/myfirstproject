module "question-service" {
  source = "./../autoscaling-with-lb-tcp-listener"
  private_dns_zone_name="${var.private_dns_zone_name}"
  env="${var.env}"
  aws_region="${var.aws_region}"
  lc_ami                        = "${lookup(var.question-service,"lc_ami")}"
  lc_instance_type              = "${lookup(var.question-service,"lc_instance_type")}"
  user_data                     = "../documents/userdata/autoscaling/question-service-userdata"
  as_max_size                   = "${lookup(var.question-service,"as_max_size")}"
  as_min_size                   = "${lookup(var.question-service,"as_min_size")}"
  # as_desired_size               = "${lookup(var.question-service,"as_desired_size")}"
  as_default_cooldown           = "${lookup(var.question-service,"as_default_cooldown")}"
  health_check_grace_period     = "${lookup(var.question-service,"health_check_grace_period")}"
  health_check_type             = "${lookup(var.question-service,"health_check_type")}"
  notification_sns_arn  ="${module.question_services_sns.sns_arn}"
  as_notification_sns_arn = "${module.question_services_as_sns.sns_arn}"

  #elb_logs_bucket=""  # instead of variable use env and rest hardcode
  #elb_logs_folder=""
  iam_instance_profile = "${aws_iam_instance_profile.autoscaling-deployment-s3logs-iam-profile.id}"

  instance_authorization_key       = "${module.vpc.auth_id}"
  as_subnet_id                     = "${module.vpc.application_subnet_id}"
  lc_sg                            = ["${aws_security_group.application_sg.id}","${module.qs_sg.sg_id}"]
  as_name                          = "question-service"
  elb_subnet                       = "${module.vpc.application_subnet_id}"
  elb_sg_id                        = "${module.qs_elb_sg.sg_id}"
  listener=[
    {
      listener_instance_port="9000"
      listener_instance_protocol="TCP"
      listener_lb_port="9000"
      listener_lb_protocol="TCP"
    }

  ]

  health_check={
    health_check_healthy_threshold   = "2"
    health_check_unhealthy_threshold = "2"
    health_check_target              = "TCP:9000"
    health_check_response_timeout = "9"
    health_check_interval         = "10"

  }
  elb_idle_timeout =  "${lookup(var.question-service,"elb_idle_timeout")}"
  elb_connection_draining = {

    set_connection_draining="${lookup(var.question-service,"set_connection_draining")}"
    connection_draining_timeout="${lookup(var.question-service,"connection_draining_timeout")}"


  }
  elb_logs = {
    elb_logs_interval = "60"
    elb_logs_enabled = "true"

  }
  ag_instance_cluster_tag = "Question Services"
  ansible_public_key = "${var.ansible_pub_key}"
  enable_monitoring="${var.enable_monitoring}"


}

module "question-service-scaling" {

  source="./../scaling-policies/cpu-utilization"
  as_name="${module.question-service.as_name_output}"
  scale_up_consecutive_periods="${lookup(var.question-service,"scale_up_consecutive_periods")}"
  scale_up_period="${lookup(var.question-service,"scale_up_period")}"
  cpu_high_threshold="${lookup(var.question-service,"cpu_high_threshold")}"
  scale_down_consecutive_periods="${lookup(var.question-service,"scale_down_consecutive_periods")}"
  scale_down_period="${lookup(var.question-service,"scale_down_period")}"
  cpu_low_threshold="${lookup(var.question-service,"cpu_low_threshold")}"
  scale_down_by_instances = "${lookup(var.question-service,"scale_down_by_instances")}"
  scale_up_by_instances = "${lookup(var.question-service,"scale_up_by_instances")}"
  scale_up_warmup = "${lookup(var.question-service,"scale_up_warmup")}"
  alarm_notification_arn = "${module.question_services_sns.sns_arn}"

}
