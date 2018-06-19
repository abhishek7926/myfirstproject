resource "aws_subnet" "ucl_subnet" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.ucl_subnet_cidr}"
  availability_zone = "${var.default_az}"

  tags {
    Name = "${format("%s", lower("private_ucl_subnet.${var.default_az}.${var.private_dns_zone_name}"))}"
  }
}

resource "aws_route_table_association" "ucl_subnet_route" {
  subnet_id      = "${aws_subnet.ucl_subnet.id}"
  route_table_id = "${aws_route_table.private_subnet_route.id}"
}


resource "aws_network_acl" "revoke_mongo_postgres" {
  vpc_id = "${aws_vpc.vpc.id}"
  subnet_ids = ["${aws_subnet.ucl_subnet.id}"]
  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = "0"
    to_port    = "0"
  }
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = "0"
    to_port    = "0"
  }
  egress {
    protocol   = "tcp"
    rule_no    = 50
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 5432
    to_port    = 5432
  }



}