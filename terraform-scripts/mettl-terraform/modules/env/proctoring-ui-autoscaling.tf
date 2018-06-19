module "proctoring-ui" {
  source = "./../autoscaling-with-lb-http-listener"
  aws_region="${var.aws_region}"
  lc_ami                        = "${lookup(var.proctoring-ui,"lc_ami")}"
  lc_instance_type              = "${lookup(var.proctoring-ui,"lc_instance_type")}"
  user_data                     = "../documents/userdata/autoscaling/proctoring-userdata"
  as_max_size                   = "${lookup(var.proctoring-ui,"as_max_size")}"
  as_min_size                   = "${lookup(var.proctoring-ui,"as_min_size")}"
  # as_desired_size               = "${lookup(var.proctoring-ui,"as_desired_size")}"
  as_default_cooldown           = "${lookup(var.proctoring-ui,"as_default_cooldown")}"
  health_check_grace_period     = "${lookup(var.proctoring-ui,"health_check_grace_period")}"
  health_check_type             = "${lookup(var.proctoring-ui,"health_check_type")}"
  iam_instance_profile = "${aws_iam_instance_profile.autoscaling-deployment-s3logs-iam-profile.id}"
  notification_sns_arn  ="${module.proctoring_sns.sns_arn}"
  as_notification_sns_arn = "${module.proctoring_as_sns.sns_arn}"

  #elb_logs_bucket=""  # instead of variable use env and rest hardcode
  #elb_logs_folder=""
  private_dns_zone_name="${var.private_dns_zone_name}"
  env="${var.env}"
  instance_authorization_key       = "${module.vpc.auth_id}"
  as_subnet_id                     = "${module.vpc.application_subnet_id}"
  lc_sg                            = ["${aws_security_group.application_sg.id}","${module.proctoring-ui-lb-sg.sg_id}"]
  as_name                          = "proctoring-ui"
  elb_subnet                       = "${module.vpc.public_subnet_id}"
  elb_sg_id                        = "${module.elb-http-sg.sg_id}"
  ssl_certificate_id               = "${var.acm_certificate_arn }"

  health_check={
    health_check_healthy_threshold   = "2"
    health_check_unhealthy_threshold = "2"
    health_check_target              = "TCP:443"
    health_check_response_timeout = "5"
    health_check_interval         = "29"
  }
  listener=
  [
    {
      listener_instance_port="80"
      listener_instance_protocol="HTTP"
      listener_lb_port="80"
      listener_lb_protocol="HTTP"
    },
    {
      listener_instance_port="443"
      listener_instance_protocol="HTTPS"
      listener_lb_port="443"
      listener_lb_protocol="HTTPS"
    }
  ]

  elb_logs = {
    elb_logs_interval = "60"
    elb_logs_enabled = "true"

  }
  elb_connection_draining = {
    set_connection_draining=true
    connection_draining_timeout="60"
  }

  ag_instance_cluster_tag = "Proctoring"
  enable_monitoring="${var.enable_monitoring}"
}


module "proctoring-ui-lb-sg" {
  source = "./../sg"
  sg_name = "${format("%s", lower("proctoring-ui-lb-sg.${var.private_dns_zone_name}"))}"
  sg_vpc_id = "${module.vpc.vpc_id}"
  sg_rule = [
    {
      type = "ingress"
      port = "80"
      protocol = "tcp"
      cidr = "${var.vpc_cidr}"
    },
    {
      type = "ingress"
      port = "443"
      protocol = "tcp"
      cidr = "${var.vpc_cidr}"
    }
  ]
}

module "proctoring-ui-scaling" {

  source="./../scaling-policies/cpu-utilization"
  as_name="${module.proctoring-ui.as_name_output}"
  scale_up_consecutive_periods="${lookup(var.proctoring-ui,"scale_up_consecutive_periods")}"
  scale_up_period="${lookup(var.proctoring-ui,"scale_up_period")}"
  cpu_high_threshold="${lookup(var.proctoring-ui,"cpu_high_threshold")}"
  scale_down_consecutive_periods="${lookup(var.proctoring-ui,"scale_down_consecutive_periods")}"
  scale_down_period="${lookup(var.proctoring-ui,"scale_down_period")}"
  cpu_low_threshold="${lookup(var.proctoring-ui,"cpu_low_threshold")}"
  scale_down_by_instances = "${lookup(var.proctoring-ui,"scale_down_by_instances")}"
  scale_up_by_instances = "${lookup(var.proctoring-ui,"scale_up_by_instances")}"
  scale_up_warmup = "${lookup(var.proctoring-ui,"scale_up_warmup")}"
  alarm_notification_arn = "${module.proctoring_sns.sns_arn}"

}