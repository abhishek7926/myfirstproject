output "elb_name_output" {
  value = "${module.as-lb-http.elb_name_output}"
}
output "as_name_output" {
  value="${module.as-with-lb-http.as_name_output}"
}
output "elb_dns_name_output" {
  value="${module.as-lb-http.elb_dns_name_output}"
}
output "elb_zone_id_output" {
  value="${module.as-lb-http.elb_zone_id_output}"
}
