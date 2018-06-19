resource "aws_route53_zone" "private_dns_zone" {
  name   = "${var.private_dns_zone_name}"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route53_zone" "public_dns_zone" {
  name   = "${var.public_dns_zone_name}"
}
