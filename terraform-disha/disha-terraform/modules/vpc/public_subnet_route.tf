resource "aws_route_table" "public_subnet_route" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.vpc_igw_id}"
  }

  tags {
    Name = "${format("%s", lower("public_subnet_route.${var.private_dns_zone_name}"))}"
  }
}
