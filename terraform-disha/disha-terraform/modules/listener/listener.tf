resource "aws_alb_listener" "http" {
  load_balancer_arn  = "${var.alb_arn}"
  port               = "${lookup(var.listener[0],"listener_port")}"
  protocol           = "${lookup(var.listener[0],"listener_protocol")}"
  "default_action" {
    target_group_arn = "${var.alb_tg_http_arn}"
    type             = "${lookup(var.listener[0],"listener_type")}"
  }
}

resource "aws_alb_listener" "https" {
  load_balancer_arn  = "${var.alb_arn}"
  port               = "${lookup(var.listener[1],"listener_port")}"
  protocol           = "${lookup(var.listener[1],"listener_protocol")}"
  certificate_arn    = "${var.ssl_certificate_arn}"
  "default_action" {
    target_group_arn = "${var.alb_tg_https_arn}"
    type             = "${lookup(var.listener[1],"listener_type")}"
  }
}

resource "aws_alb_listener_certificate" "example" {
  count = "${length(var.additional_ssl_arn)}"
  listener_arn    = "${aws_alb_listener.https.arn}"
  certificate_arn = "${element(var.additional_ssl_arn, count.index)}"
}


resource "aws_alb_listener_rule" "rule_http" {
  count = "${var.count_rules_http}"
  listener_arn = "${var.listener_arn_http}"
  priority     = "${count.index+var.base_priority_http}"
  action {
    type             = "forward"
    target_group_arn = "${lookup(var.rules_http[count.index], "group_arn")}"
  }
  condition {
    field  = "${lookup(var.rules_http[count.index], "field")}"
    values = [ "${lookup(var.rules_http[count.index], "value")}" ]
  }

}

resource "aws_alb_listener_rule" "rule_https" {
  count = "${var.count_rules_https}"
  listener_arn = "${var.listener_arn_https}"
  priority     = "${count.index+var.base_priority_https}"
  action {
    type             = "forward"
    target_group_arn = "${lookup(var.rules_https[count.index], "group_arn")}"
  }
  condition {
    field  = "${lookup(var.rules_https[count.index], "field")}"
    values = [ "${lookup(var.rules_https[count.index], "value")}" ]
  }

}