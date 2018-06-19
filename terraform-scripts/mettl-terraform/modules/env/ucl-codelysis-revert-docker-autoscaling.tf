module "ucl-codelysis-revert-plan" {
  source = "./../autoscaling-with-lb-tcp-listener"
  private_dns_zone_name="${var.private_dns_zone_name}"
  env="${var.env}"
  aws_region="${var.aws_region}"
  lc_ami                        = "${lookup(var.ucl-codelysis-revert,"lc_ami")}"
  lc_instance_type              = "${lookup(var.ucl-codelysis-revert,"lc_instance_type")}"
  user_data                     = "../documents/userdata/autoscaling/ucl-codelysis-userdata"
  as_max_size                   = "${lookup(var.ucl-codelysis-revert,"as_max_size")}"
  as_min_size                   = "${lookup(var.ucl-codelysis-revert,"as_min_size")}"
  # as_desired_size               = "${lookup(var.ucl-codelysis-revert,"as_desired_size")}"
  as_default_cooldown           = "${lookup(var.ucl-codelysis-revert,"as_default_cooldown")}"
  health_check_grace_period     = "${lookup(var.ucl-codelysis-revert,"health_check_grace_period")}"
  health_check_type             = "${lookup(var.ucl-codelysis-revert,"health_check_type")}"
  notification_sns_arn  ="${module.simulators_sns.sns_arn}"
  as_notification_sns_arn = "${module.simulators_as_sns.sns_arn}"

  #elb_logs_bucket=""  # instead of variable use env and rest hardcode
  #elb_logs_folder=""
  iam_instance_profile = "${aws_iam_instance_profile.autoscaling-deployment-s3logs-iam-profile.id}"

  instance_authorization_key       = "${module.vpc.auth_id}"
  as_subnet_id                     = "${module.vpc.ucl_subnet_id}"
  lc_sg                            = ["${aws_security_group.application_sg.id}","${module.ucl_sg.sg_id}"]
  as_name                          = "Ucl-codelysis-revert"
  elb_subnet                       = "${module.vpc.application_subnet_id}"
  elb_sg_id                        = "${module.ucl_elb_sg.sg_id}"
  listener=[
    {
      listener_instance_port="9311"
      listener_instance_protocol="TCP"
      listener_lb_port="9411"
      listener_lb_protocol="TCP"
    }

  ]

  health_check={
    health_check_healthy_threshold   = "2"
    health_check_unhealthy_threshold = "2"
    health_check_target              = "TCP:9311"
    health_check_response_timeout = "9"
    health_check_interval         = "10"

  }
  elb_idle_timeout =  "${lookup(var.ucl-codelysis-revert,"elb_idle_timeout")}"
  elb_connection_draining = {

    set_connection_draining="${lookup(var.ucl-codelysis-revert,"set_connection_draining")}"
    connection_draining_timeout="${lookup(var.ucl-codelysis-revert,"connection_draining_timeout")}"


  }
  elb_logs = {
    elb_logs_interval = "60"
    elb_logs_enabled = "true"

  }
  ag_instance_cluster_tag = "Simulators"
  ansible_public_key = "${var.ansible_pub_key}"
  enable_monitoring="${var.enable_monitoring}"
  disk_paths           =  [

    {
      Filesystem="/dev/xvdc"
      MountPath="/home/mettl/volume1"
    },
    {
      Filesystem="/dev/xvda1"
      MountPath="/"
    },
    {
      Filesystem = "/dev/xvdb"
      MountPath = "/home/mettl/mettl_logs"
    }



  ]

}

module "ucl-codelysis-revert-scaling" {

  source="./../scaling-policies/cpu-utilization"
  as_name="${module.ucl-codelysis-revert-plan.as_name_output}"
  scale_up_consecutive_periods="${lookup(var.ucl-codelysis-revert,"scale_up_consecutive_periods")}"
  scale_up_period="${lookup(var.ucl-codelysis-revert,"scale_up_period")}"
  cpu_high_threshold="${lookup(var.ucl-codelysis-revert,"cpu_high_threshold")}"
  scale_down_consecutive_periods="${lookup(var.ucl-codelysis-revert,"scale_down_consecutive_periods")}"
  scale_down_period="${lookup(var.ucl-codelysis-revert,"scale_down_period")}"
  cpu_low_threshold="${lookup(var.ucl-codelysis-revert,"cpu_low_threshold")}"
  scale_down_by_instances = "${lookup(var.ucl-codelysis-revert,"scale_down_by_instances")}"
  scale_up_by_instances = "${lookup(var.ucl-codelysis-revert,"scale_up_by_instances")}"
  scale_up_warmup = "${lookup(var.ucl-codelysis-revert,"scale_up_warmup")}"
  alarm_notification_arn = "${module.simulators_sns.sns_arn}"

}