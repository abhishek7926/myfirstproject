resource "aws_security_group" "application_sg" {
  name        = "${var.env}-application-sg"
  description = "for zabbix and ssh"
  vpc_id      = "${module.vpc.vpc_id}"


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks =["${var.vpc_cidr}"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = "true"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.env}-application-sg"
  }
}


