resource "aws_route_table" "public_subnet_route" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${format("%s", lower("public_subnet_route.${var.private_dns_zone_name}"))}"
  }
}
