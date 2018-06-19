resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${format("%s", lower("igw.${var.private_dns_zone_name}"))}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.public_subnet_cidr}"

  #  map_public_ip_on_launch = false
  availability_zone = "${var.default_az}"

  tags {
    Name = "${format("%s", lower("public-subnet.${var.default_az}.${var.private_dns_zone_name}"))}"
  }
}

resource "aws_route_table_association" "public_subnet_route" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public_subnet_route.id}"
}

resource "aws_subnet" "additional_public_subnet" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.additional_public_subnet_cidr}"

  #  map_public_ip_on_launch = false
  availability_zone = "${var.additional_az}"

  tags {
    Name = "${format("%s", lower("public-subnet.${var.additional_az}.${var.private_dns_zone_name}"))}"
  }
}

resource "aws_route_table_association" "additional_public_subnet_route" {
  subnet_id      = "${aws_subnet.additional_public_subnet.id}"
  route_table_id = "${aws_route_table.public_subnet_route.id}"
}