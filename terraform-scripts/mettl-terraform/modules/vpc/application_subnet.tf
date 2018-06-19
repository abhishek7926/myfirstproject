resource "aws_subnet" "application_subnet" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.application_subnet_cidr}"
  availability_zone = "${var.default_az}"

  tags {
    Name = "${format("%s", lower("private_application_subnet.${var.default_az}.${var.private_dns_zone_name}"))}"
  }
}

resource "aws_route_table_association" "application_subnet_route" {
  subnet_id      = "${aws_subnet.application_subnet.id}"
  route_table_id = "${aws_route_table.private_subnet_route.id}"
}


resource "aws_subnet" "additional_application_subnet" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.additional_application_subnet_cidr}"
  availability_zone = "${var.additional_az}"

  tags {
    Name = "${format("%s", lower("private_application_subnet.${var.additional_az}.${var.private_dns_zone_name}"))}"
  }
}

resource "aws_route_table_association" "additional_application_subnet_route" {
  subnet_id      = "${aws_subnet.additional_application_subnet.id}"
  route_table_id = "${aws_route_table.private_subnet_route.id}"
}
