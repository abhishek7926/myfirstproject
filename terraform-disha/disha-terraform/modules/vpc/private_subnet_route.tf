resource "aws_route_table" "private_subnet_route" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block  = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gateway.id}"
  }

  tags {
    Name = "${format("%s", lower("private_subnet_route.${var.private_dns_zone_name}"))}"

  }
}
