resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${var.nat_eip_allocation_id}"
  subnet_id     = "${aws_subnet.public_subnet.id}"
}
