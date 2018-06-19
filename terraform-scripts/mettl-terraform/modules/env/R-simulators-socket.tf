  module "r-socket" {
  source = "./../autoscaling-with-lb-http-listener"
  aws_region="${var.aws_region}"
  lc_ami                        = "${lookup(var.r-socket,"lc_ami")}"
  lc_instance_type              = "${lookup(var.r-socket,"lc_instance_type")}"
  user_data                     = "../documents/userdata/autoscaling/r-socket-userdata"
  as_max_size                   = "${lookup(var.r-socket,"as_max_size")}"
  as_min_size                   = "${lookup(var.r-socket,"as_min_size")}"
  # as_desired_size               = "${lookup(var.r-socket,"as_desired_size")}"
  as_default_cooldown           = "${lookup(var.r-socket,"as_default_cooldown")}"
  health_check_grace_period     = "${lookup(var.r-socket,"health_check_grace_period")}"
  health_check_type             = "${lookup(var.r-socket,"health_check_type")}"
  iam_instance_profile = "${aws_iam_instance_profile.autoscaling-deployment-s3logs-iam-profile.id}"
  #elb_logs_bucket=""  # instead of variable use env and rest hardcode
  #elb_logs_folder=""
  private_dns_zone_name="${var.private_dns_zone_name}"
  env="${var.env}"
  instance_authorization_key       = "${module.vpc.auth_id}"
  as_subnet_id                     = "${module.vpc.application_subnet_id}"
  lc_sg                            = ["${aws_security_group.application_sg.id}","${module.r_socket_sg.sg_id}","${aws_security_group.r-simulator-hazelcast.id}"]
  as_name                          = "r-socket"
  elb_subnet                       = "${module.vpc.public_subnet_id}"
  elb_sg_id                        = "${module.elb-http-sg.sg_id}"
  ssl_certificate_id               = "${var.acm_certificate_arn }"
  health_check={
    health_check_healthy_threshold   = "2"
    health_check_unhealthy_threshold = "2"
    health_check_target              = "HTTP:10000/ping"
    health_check_response_timeout = "9"
    health_check_interval         = "11"

  }
  elb_logs = {
    elb_logs_interval = "60"
    elb_logs_enabled = "true"

  }
  elb_connection_draining = {
    set_connection_draining=true
    connection_draining_timeout="300"
  }

  listener = [
    {
      listener_instance_port="80"
      listener_instance_protocol="HTTP"
      listener_lb_port="80"
      listener_lb_protocol="HTTP"
    },
    {
      listener_instance_port="10000"
      listener_instance_protocol="TCP"
      listener_lb_port="443"
      listener_lb_protocol="SSL"
    },
  ]

  ag_instance_cluster_tag = "Simulators"
  notification_sns_arn  ="${module.simulators_sns.sns_arn}"
  enable_monitoring="${var.enable_monitoring}"
  as_notification_sns_arn = "${module.simulators_as_sns.sns_arn}"

}

module "r_socket_sg" {
  source            = "./../sg"
  sg_name           = "${format("%s", lower("r-socket-sg.${var.private_dns_zone_name}"))}"
  sg_vpc_id         = "${module.vpc.vpc_id}"
  sg_rule=[
    {
      type="ingress"
      port="10000"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="egress"
      port="0"
      protocol="-1"
      cidr="0.0.0.0/0"
    }
  ]
}
