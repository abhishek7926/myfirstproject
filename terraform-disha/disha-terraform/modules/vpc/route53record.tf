resource "aws_route53_zone" "private_dns_zone" {
  name   = "${var.private_dns_zone_name}"
  vpc_id = "${var.vpc_id}"
}

resource "aws_route53_zone" "public_dns_zone" {
  name   = "${var.public_dns_zone_name}"
}

resource "aws_route53_zone" "public_dns_zone_info" {
  count  = "${var.is_info_new_domain ? 1 : 0}"
  name   = "${var.public_dns_info_zone_name}"
}