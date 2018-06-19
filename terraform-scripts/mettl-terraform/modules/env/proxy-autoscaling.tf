module "proxy" {
  source = "./../autoscaling-with-lb-http-listener"
  aws_region="${var.aws_region}"
  lc_ami                        = "${lookup(var.proxy,"lc_ami")}"
  lc_instance_type              = "${lookup(var.proxy,"lc_instance_type")}"
  user_data                     = "../documents/userdata/autoscaling/proxy-userdata"
  as_max_size                   = "${lookup(var.proxy,"as_max_size")}"
  as_min_size                   = "${lookup(var.proxy,"as_min_size")}"
  #as_desired_size               = "${lookup(var.proxy,"as_desired_size")}"
  as_default_cooldown           = "${lookup(var.proxy,"as_default_cooldown")}"
  health_check_grace_period     = "${lookup(var.proxy,"health_check_grace_period")}"
  health_check_type             = "${lookup(var.proxy,"health_check_type")}"
  is_internal="false"
  iam_instance_profile = "${aws_iam_instance_profile.instance-profile.id}"
  notification_sns_arn  ="${module.platform_sns.sns_arn}"
  as_notification_sns_arn = "${module.platform_as_sns.sns_arn}"

  #elb_logs_bucket=""  # instead of variable use env and rest hardcode
  #elb_logs_folder=""
  private_dns_zone_name="${var.private_dns_zone_name}"
  env="${var.env}"
  instance_authorization_key       = "${module.vpc.auth_id}"
  as_subnet_id                     = "${module.vpc.application_subnet_id}"
  lc_sg                            = ["${aws_security_group.application_sg.id}","${module.proxy-sg.sg_id}"]
  as_name                          = "proxy"
  elb_subnet                       = "${module.vpc.public_subnet_id}"
  elb_sg_id                        = "${module.elb-http-sg.sg_id}"
  elb_idle_timeout                 = "360"
  ssl_certificate_id               = "${var.acm_certificate_arn }"
  listener=[
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

  health_check={
  health_check_healthy_threshold   = "2"
  health_check_unhealthy_threshold = "2"
  health_check_target              = "TCP:443"
  health_check_response_timeout = "2"
  health_check_interval         = "5"
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

  enable_monitoring="${var.enable_monitoring}"
  disk_paths                 = "${var.maintenance_ami_disk_paths}"
}

module "proxy-sg" {
  source = "./../sg"
  sg_name = "${format("%s", lower("proxy-sg.${var.private_dns_zone_name}"))}"
  sg_vpc_id = "${module.vpc.vpc_id}"
  sg_rule = [
    {
      type = "ingress"
      port = "80"
      protocol = "tcp"
      cidr = "0.0.0.0/0"
    },
    {
      type = "ingress"
      port = "443"
      protocol = "tcp"
      cidr = "0.0.0.0/0"
    }

  ]
}




