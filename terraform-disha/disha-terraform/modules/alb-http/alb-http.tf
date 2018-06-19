resource "aws_alb" "alb" {
  name               = "${var.env}-${var.alb_name}-lb"
  internal           = "${var.is_internal}"
  security_groups    = ["${var.alb_sg_id}"]
  subnets            = ["${var.alb_subnets}"]

  access_logs {
    bucket           = "${var.env}-elb-logs"
    prefix           = "${var.env}-${var.alb_name}"
//    interval         = "${lookup(var.alb_logs,"alb_logs_interval")}"
    enabled          = "${lookup(var.alb_logs,"alb_logs_enabled")}"

  }
}
