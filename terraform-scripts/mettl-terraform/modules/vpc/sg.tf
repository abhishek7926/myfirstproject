resource "aws_security_group" "default-sg" {
  name        = "${format("%s", lower("default-sg.${var.private_dns_zone_name}"))}"
  description = "Added as it is mandatory for instance module to have 2 sgs"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress{
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }
  ingress{
    from_port   = 10050
    to_port     = 10050
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


