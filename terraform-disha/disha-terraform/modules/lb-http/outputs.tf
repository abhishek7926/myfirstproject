output "elb_name_output" {
  value = "${aws_elb.elb-http.name}"
}
output "elb_dns_name_output" {
  value="${aws_elb.elb-http.dns_name}"
}
output "elb_zone_id_output" {
  value="${aws_elb.elb-http.zone_id}"
}
output "elb_id"{
value="${aws_elb.elb-http.id}"
}