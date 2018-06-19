output "elb_name_output" {
  value = "${module.as-lb-tcp.elb_name_output}"
}
output "as_name_output" {
  value="${module.as-with-lb-tcp.as_name_output}"
}
output "elb_dns_name_output" {
  value="${module.as-lb-tcp.elb_dns_name_output}"
}
output "elb_zone_id_output" {
  value="${module.as-lb-tcp.elb_zone_id_output}"
}