//module "chatweb-socket" {
//  source = "./../autoscaling-with-lb-http-listener"
//  aws_region="${var.aws_region}"
//  lc_ami                        = "${lookup(var.chatweb-socket,"lc_ami")}"
//  lc_instance_type              = "${lookup(var.chatweb-socket,"lc_instance_type")}"
//  user_data                     = "${lookup(var.chatweb-socket,"user_data_file_name")}"
//  as_max_size                   = "${lookup(var.chatweb-socket,"as_max_size")}"
//  as_min_size                   = "${lookup(var.chatweb-socket,"as_min_size")}"
//  #as_desired_size               = "${lookup(var.chatweb-socket,"as_desired_size")}"
//  as_default_cooldown           = "${lookup(var.chatweb-socket,"as_default_cooldown")}"
//  health_check_grace_period     = "${lookup(var.chatweb-socket,"health_check_grace_period")}"
//  health_check_type             = "${lookup(var.chatweb-socket,"health_check_type")}"
//  is_internal="true"
//  iam_instance_profile = "${aws_iam_instance_profile.autoscaling-deployment-s3logs-iam-profile.id}"
//  notification_sns_arn  ="${module.proctoring_sns.sns_arn}"
//
//  #elb_logs_bucket=""  # instead of variable use env and rest hardcode
//  #elb_logs_folder=""
//  private_dns_zone_name="${var.private_dns_zone_name}"
//  env="${var.env}"
//  instance_authorization_key       = "${module.vpc.auth_id}"
//  as_subnet_id                     = "${module.vpc.application_subnet_id}"
//  lc_sg                            = ["${aws_security_group.application_sg.id}","${module.chat-web-socket-sg.sg_id}",
//    "${aws_security_group.hazelcast.id}"]
//  as_name                          = "Chatweb-Socket"
//  elb_subnet                       = "${module.vpc.application_subnet_id}"
//  elb_sg_id                        = "${module.elb-http-sg.sg_id}"
//  ssl_certificate_id               = "${var.acm_certificate_arn }"
//  listener=[
//    {
//      listener_instance_port="8090"
//      listener_instance_protocol="TCP"
//      listener_lb_port="80"
//      listener_lb_protocol="TCP"
//    },
//    {
//      listener_instance_port="8090"
//      listener_instance_protocol="TCP"
//      listener_lb_port="443"
//      listener_lb_protocol="SSL"
//    }
//
//  ]
//  health_check={
//  health_check_healthy_threshold   = "2"
//  health_check_unhealthy_threshold = "2"
//  health_check_target              = "HTTP:8090/ping"
//  health_check_response_timeout = "${lookup(var.chatweb-socket,"health_check_response_timeout")}"
//  health_check_interval         = "${lookup(var.chatweb-socket,"health_check_interval")}"
//}
//  elb_logs = {
//    elb_logs_interval = "${lookup(var.chatweb-socket,"elb_logs_interval")}"
//    elb_logs_enabled = "${lookup(var.chatweb-socket,"elb_logs_enabled")}"
//
//  }
//  elb_connection_draining = {
//    set_connection_draining=false
//    connection_draining_timeout="300"
//  }
//
//  ag_instance_cluster_tag = "Proctoring"
//  notification_sns_arn  ="${module.proctoring_sns.sns_arn}"
//
// enable_monitoring="${var.enable_monitoring}"
//}
//
//module "chat-web-socket-sg" {
//  source = "./../sg"
//  sg_name = "${format("%s", lower("chat-web-socket-sg.${var.private_dns_zone_name}"))}"
//  sg_vpc_id = "${module.vpc.vpc_id}"
//  sg_rule = [
//    {
//      type = "ingress"
//      port = "8090"
//      protocol = "tcp"
//      cidr = "${var.vpc_cidr}"
//    }]
//}
//
//
//
//
//
//
