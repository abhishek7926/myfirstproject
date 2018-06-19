output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "auth_id" {
  value = "${aws_key_pair.auth.id}"
}

output "public_subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}

output "maintenance_subnet_id" {
  value = "${aws_subnet.maintenance_subnet.id}"
}


output "application_subnet_id" {
  value = "${aws_subnet.application_subnet.id}"
}
output "ucl_subnet_id" {
  value = "${aws_subnet.ucl_subnet.id}"
}

//output "nat_id" {
//  value = "${aws_instance.nat.id}"
//}

output "private_route53_zone_id" {
  value = "${aws_route53_zone.private_dns_zone.zone_id}"
}

output "public_route53_zone_id" {
  value = "${aws_route53_zone.public_dns_zone.zone_id}"
}

output "default_sg_id" {value="${aws_security_group.default-sg.id}"}
