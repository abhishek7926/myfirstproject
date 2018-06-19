module "as-lb-http" {
  source                           = "../lb-http"
  lb_name                          = "pmgdisha-info"
  elb_subnet                       = "${module.vpc.public_subnet_id}"
  elb_sg_id                        = "${module.elb-http-sg.sg_id}"
  health_check                     = {
  health_check_healthy_threshold   = "2"
  health_check_unhealthy_threshold = "2"
  health_check_target              = "TCP:8050"
  health_check_response_timeout    = "${lookup(var.pmgdisha-info,"health_check_response_timeout")}"
  health_check_interval            = "${lookup(var.pmgdisha-info,"health_check_interval")}"
  }
  ssl_certificate_id               = "${var.info-acm-arn}"
  env                              = "${var.env}"
  listener=[
    {
      listener_instance_port="80"
      listener_instance_protocol="HTTP"
      listener_lb_port="80"
      listener_lb_protocol="HTTP"
    },
    {
      listener_instance_port="8050"
      listener_instance_protocol="HTTP"
      listener_lb_port="443"
      listener_lb_protocol="HTTPS"
    }
  ]
  is_internal="${var.is_internal}"
  elb_connection_draining = {
    set_connection_draining=true
    connection_draining_timeout="60"
  }
  elb_logs = {
    elb_logs_interval = "${lookup(var.pmgdisha-info,"elb_logs_interval")}"
    elb_logs_enabled = "${lookup(var.pmgdisha-info,"elb_logs_enabled")}"

  }
  notification_sns_arn="${module.disha_sns.sns_arn}"

}

resource "aws_elb_attachment" "pmgdisha" {
  elb = "${module.as-lb-http.elb_id}"
  instance = "${module.pmgdisha_info_instance.instance_id}"
}