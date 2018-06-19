resource "aws_security_group" "application_sg" {
  name        = "${format("%s", lower("application-sg.${var.private_dns_zone_name}"))}"
  description = "for zabbix and ssh"
  vpc_id      = "${module.vpc.vpc_id}"



  ingress {
    from_port   = 10050
    to_port     = 10050
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks =["${var.vpc_cidr}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${format("%s", lower("application-sg.${var.private_dns_zone_name}"))}"
  }
}


