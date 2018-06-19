module "assessment-service" {
  source = "./../autoscaling-with-lb-tcp-listener"
  aws_region="${var.aws_region}"
  lc_ami                        = "${lookup(var.assessment-service,"lc_ami")}"
  lc_instance_type              = "${lookup(var.assessment-service,"lc_instance_type")}"
  user_data                     = "../documents/userdata/autoscaling/assessment-service-api-userdata"
  as_max_size                   = "${lookup(var.assessment-service,"as_max_size")}"
  as_min_size                   = "${lookup(var.assessment-service,"as_min_size")}"
  as_default_cooldown           = "${lookup(var.assessment-service,"as_default_cooldown")}"
  health_check_grace_period     = "${lookup(var.assessment-service,"health_check_grace_period")}"
  health_check_type             = "${lookup(var.assessment-service,"health_check_type")}"
  private_dns_zone_name="${var.private_dns_zone_name}"
  notification_sns_arn  ="${module.platform_sns.sns_arn}"
  as_notification_sns_arn = "${module.platform_as_sns.sns_arn}"

  env="${var.env}"

  iam_instance_profile = "${aws_iam_instance_profile.autoscaling-deployment-s3logs-iam-profile.id}"

  instance_authorization_key       = "${module.vpc.auth_id}"
  as_subnet_id                     = "${module.vpc.application_subnet_id}"
  lc_sg                            = ["${aws_security_group.application_sg.id}","${aws_security_group.assessment-service-sg.id}"]
  as_name                          = "assessment-service"
  elb_subnet                       = "${module.vpc.application_subnet_id}"
  elb_sg_id                        = "${module.internal-elb-http-sg.sg_id}"
  listener=
  [
    {
      listener_instance_port="8050"
      listener_instance_protocol="TCP"
      listener_lb_port="80"
      listener_lb_protocol="TCP"
    },
    {
      listener_instance_port="8050"
      listener_instance_protocol="TCP"
      listener_lb_port="443"
      listener_lb_protocol="SSL"
    }
  ]
  health_check={
    health_check_healthy_threshold   = "2"
    health_check_unhealthy_threshold = "2"
    health_check_target              = "HTTP:8050/corporate/assessment/v1/ping"
    health_check_response_timeout = "${lookup(var.assessment-service,"health_check_response_timeout")}"
    health_check_interval         = "${lookup(var.assessment-service,"health_check_interval")}"
  }
  elb_idle_timeout =  "${lookup(var.assessment-service,"elb_idle_timeout")}"
  elb_connection_draining = {

    set_connection_draining="${lookup(var.assessment-service,"set_connection_draining")}"
    connection_draining_timeout="${lookup(var.assessment-service,"connection_draining_timeout")}"


  }
  elb_logs = {
    elb_logs_interval = "${lookup(var.assessment-service,"elb_logs_interval")}"
    elb_logs_enabled = "${lookup(var.assessment-service,"elb_logs_enabled")}"

  }
  ag_instance_cluster_tag = "Platform"

  enable_monitoring="${var.enable_monitoring}"
}

resource "aws_security_group" "assessment-service-sg" {
  name = "${format("%s", lower("assessment-service-sg.${var.private_dns_zone_name}"))}"
  description = "assessment-service-sg"
  vpc_id = "${module.vpc.vpc_id}"
  ingress {
    from_port =8050
    to_port =8050
    protocol = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]        }
  tags {
    Name = "${format("%s", lower("assessment-service-sg.${var.private_dns_zone_name}"))}"


  }

}

module "assessment-service-scaling" {

  source="./../scaling-policies/cpu-utilization"
  as_name="${module.assessment-service.as_name_output}"
  scale_up_consecutive_periods="${lookup(var.assessment-service,"scale_up_consecutive_periods")}"
  scale_up_period="${lookup(var.assessment-service,"scale_up_period")}"
  cpu_high_threshold="${lookup(var.assessment-service,"cpu_high_threshold")}"
  scale_down_consecutive_periods="${lookup(var.assessment-service,"scale_down_consecutive_periods")}"
  scale_down_period="${lookup(var.assessment-service,"scale_down_period")}"
  cpu_low_threshold="${lookup(var.assessment-service,"cpu_low_threshold")}"
  scale_down_by_instances = "${lookup(var.assessment-service,"scale_down_by_instances")}"
  scale_up_by_instances = "${lookup(var.assessment-service,"scale_up_by_instances")}"
  scale_up_warmup = "${lookup(var.assessment-service,"scale_up_warmup")}"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"

}
