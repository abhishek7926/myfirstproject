output "elb_name_output" {
  value = "${aws_elb.elb-tcp.name}"
}
output "elb_dns_name_output" {
  value="${aws_elb.elb-tcp.dns_name}"
}
output "elb_zone_id_output" {
  value="${aws_elb.elb-tcp.zone_id}"
}