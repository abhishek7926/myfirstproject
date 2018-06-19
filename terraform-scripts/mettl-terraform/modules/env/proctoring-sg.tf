resource "aws_security_group" "hazelcast" {
  name = "${format("%s", lower("Hazelcast-chat-web-socket-sg.${var.private_dns_zone_name}"))}"
  description = "hazelcast"
  vpc_id = "${module.vpc.vpc_id}"
  ingress {
    from_port =5701
    to_port =5801
    protocol = "tcp"
    self = true
  },


ingress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["${var.vpc_cidr}"]
}

  tags {
    Name = "${format("%s", lower("Hazelcast-chat-web-socket-sg.${var.private_dns_zone_name}"))}"


  }

}

resource "aws_security_group" "livefeed-hazelcast" {
  name = "${format("%s", lower("Hazelcast-livefeed-sg.${var.private_dns_zone_name}"))}"
  description = "livefeed hazelcast"
  vpc_id = "${module.vpc.vpc_id}"
  ingress {
    from_port =5701
    to_port =5801
    protocol = "tcp"
    self = true
  },


  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  tags {
    Name = "${format("%s", lower("Hazelcast-livefeed-sg.${var.private_dns_zone_name}"))}"


  }

}