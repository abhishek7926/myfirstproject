module "java-codelysis" {
  source = "./../autoscaling-with-lb-tcp-listener"
  aws_region="${var.aws_region}"
  lc_ami                        = "${lookup(var.java-codelysis,"lc_ami")}"
  lc_instance_type              = "${lookup(var.java-codelysis,"lc_instance_type")}"
  user_data                     = "../documents/userdata/autoscaling/java-codelysis-userdata"
  as_max_size                   = "${lookup(var.java-codelysis,"as_max_size")}"
  as_min_size                   = "${lookup(var.java-codelysis,"as_min_size")}"
  # as_desired_size               = "${lookup(var.java-codelysis,"as_desired_size")}"
  as_default_cooldown           = "${lookup(var.java-codelysis,"as_default_cooldown")}"
  health_check_grace_period     = "${lookup(var.java-codelysis,"health_check_grace_period")}"
  health_check_type             = "${lookup(var.java-codelysis,"health_check_type")}"
  private_dns_zone_name="${var.private_dns_zone_name}"
  notification_sns_arn  ="${module.simulators_sns.sns_arn}"
  as_notification_sns_arn = "${module.simulators_as_sns.sns_arn}"

  env="${var.env}"
  #elb_logs_bucket=""  # instead of variable use env and rest hardcode
  #elb_logs_folder=""
  iam_instance_profile = "${aws_iam_instance_profile.autoscaling-deployment-s3logs-iam-profile.id}"

  instance_authorization_key       = "${module.vpc.auth_id}"
  as_subnet_id                     = "${module.vpc.application_subnet_id}"
  lc_sg                            = ["${aws_security_group.application_sg.id}","${aws_security_group.java-codelysis-sg.id}"]
  as_name                          = "java-codelysis"
  elb_subnet                       = "${module.vpc.application_subnet_id}"
  elb_sg_id                        = "${module.codelysis_elb_sg.sg_id}"
  listener=[
    {
      listener_instance_port="7896"
      listener_instance_protocol="TCP"
      listener_lb_port="7896"
      listener_lb_protocol="TCP"
    }

  ]

  health_check={
    health_check_healthy_threshold   = "2"
    health_check_unhealthy_threshold = "2"
    health_check_target              = "TCP:7896"
    health_check_response_timeout = "4"
    health_check_interval         = "5"
  }
  elb_idle_timeout =  "${lookup(var.java-codelysis,"elb_idle_timeout")}"
  elb_connection_draining = {

    set_connection_draining="${lookup(var.java-codelysis,"set_connection_draining")}"
    connection_draining_timeout="${lookup(var.java-codelysis,"connection_draining_timeout")}"


  }
  elb_logs = {
    elb_logs_interval = "60"
    elb_logs_enabled = "true"

  }
  ag_instance_cluster_tag = "Simulators"

  enable_monitoring="${var.enable_monitoring}"
}

resource "aws_security_group" "java-codelysis-sg" {
  name = "${format("%s", lower("java-codelysis-sg.${var.private_dns_zone_name}"))}"
  description = "java-codelysis-sg"
  vpc_id = "${module.vpc.vpc_id}"
  ingress {
    from_port =7896
    to_port =7896
    protocol = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]        }
  tags {
    Name = "${format("%s", lower("java-codelysis-sg.${var.private_dns_zone_name}"))}"


  }

}
