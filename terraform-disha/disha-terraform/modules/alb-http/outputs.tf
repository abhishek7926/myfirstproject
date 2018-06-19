output "alb_arn_output" {
  value = "${aws_alb.alb.arn}"
}

output "alb_dns_output" {
  value = "${aws_alb.alb.dns_name}"
}

output "alb_zone_id_output" {
  value = "${aws_alb.alb.zone_id}"
}