module "plagiarism" {
  source = "./../autoscaling-with-lb-tcp-listener"
  aws_region="${var.aws_region}"
  lc_ami                        = "${lookup(var.plagiarism,"lc_ami")}"
  lc_instance_type              = "${lookup(var.plagiarism,"lc_instance_type")}"
  user_data                     = "../documents/userdata/autoscaling/plagiarism-userdata"
  as_max_size                   = "${lookup(var.plagiarism,"as_max_size")}"
  as_min_size                   = "${lookup(var.plagiarism,"as_min_size")}"
  as_default_cooldown           = "${lookup(var.plagiarism,"as_default_cooldown")}"
  health_check_grace_period     = "${lookup(var.plagiarism,"health_check_grace_period")}"
  health_check_type             = "${lookup(var.plagiarism,"health_check_type")}"
  private_dns_zone_name="${var.private_dns_zone_name}"
  notification_sns_arn  ="${module.platform_sns.sns_arn}"
  as_notification_sns_arn = "${module.platform_as_sns.sns_arn}"

  env="${var.env}"

  iam_instance_profile = "${aws_iam_instance_profile.autoscaling-deployment-s3logs-iam-profile.id}"

  instance_authorization_key       = "${module.vpc.auth_id}"
  as_subnet_id                     = "${module.vpc.application_subnet_id}"
  lc_sg                            = ["${aws_security_group.application_sg.id}","${aws_security_group.plagiarism-sg.id}"]
  as_name                          = "plagiarism"
  elb_subnet                       = "${module.vpc.application_subnet_id}"
  elb_sg_id                        = "${aws_security_group.plagiarism-sg.id}"
  listener=
  [
    {
      listener_instance_port="8080"
      listener_instance_protocol="TCP"
      listener_lb_port="8080"
      listener_lb_protocol="TCP"
    }
  ]
  health_check={
    health_check_healthy_threshold   = "2"
    health_check_unhealthy_threshold = "2"
    health_check_target              = "HTTP:8080/ping"
    health_check_response_timeout = "${lookup(var.plagiarism,"health_check_response_timeout")}"
    health_check_interval         = "${lookup(var.plagiarism,"health_check_interval")}"
  }
  elb_idle_timeout =  "${lookup(var.plagiarism,"elb_idle_timeout")}"
  elb_connection_draining = {

    set_connection_draining="${lookup(var.plagiarism,"set_connection_draining")}"
    connection_draining_timeout="${lookup(var.plagiarism,"connection_draining_timeout")}"


  }
  elb_logs = {
    elb_logs_interval = "${lookup(var.plagiarism,"elb_logs_interval")}"
    elb_logs_enabled = "${lookup(var.plagiarism,"elb_logs_enabled")}"

  }
  ag_instance_cluster_tag = "Platform"

  enable_monitoring="${var.enable_monitoring}"
}

resource "aws_security_group" "plagiarism-sg" {
  name = "${format("%s", lower("plagiarism-sg.${var.private_dns_zone_name}"))}"
  description = "plagiarism-sg"
  vpc_id = "${module.vpc.vpc_id}"
  ingress {
    from_port =8080
    to_port =8080
    protocol = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]        }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${format("%s", lower("plagiarism-sg.${var.private_dns_zone_name}"))}"


  }

}

module "plagiarism-scaling" {

  source="./../scaling-policies/cpu-utilization"
  as_name="${module.plagiarism.as_name_output}"
  scale_up_consecutive_periods="${lookup(var.plagiarism,"scale_up_consecutive_periods")}"
  scale_up_period="${lookup(var.plagiarism,"scale_up_period")}"
  cpu_high_threshold="${lookup(var.plagiarism,"cpu_high_threshold")}"
  scale_down_consecutive_periods="${lookup(var.plagiarism,"scale_down_consecutive_periods")}"
  scale_down_period="${lookup(var.plagiarism,"scale_down_period")}"
  cpu_low_threshold="${lookup(var.plagiarism,"cpu_low_threshold")}"
  scale_down_by_instances = "${lookup(var.plagiarism,"scale_down_by_instances")}"
  scale_up_by_instances = "${lookup(var.plagiarism,"scale_up_by_instances")}"
  scale_up_warmup = "${lookup(var.plagiarism,"scale_up_warmup")}"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"

}
