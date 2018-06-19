resource "aws_security_group" "redshift_sg" {
  name = "redshift-sg"
  vpc_id     = "${module.vpc.vpc_id}"
  description = "redshift-sg"
  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

}


resource "aws_redshift_subnet_group" "redshift_cluster_subnet_group" {
  name       = "report-automation-${var.env}"
  subnet_ids = ["${module.vpc.maintenance_subnet_id}"]
}


resource "aws_redshift_cluster" "report-redshift-cluster" {
  count="${var.redshift_count}"
  cluster_identifier = "${var.env}-report"
  database_name      = "report_automation"
  cluster_subnet_group_name = "${aws_redshift_subnet_group.redshift_cluster_subnet_group.name}"
  master_username    = "report_redshift_admin"
  master_password    = "utdkXJ7LmpbY8RfY"
  node_type          = "dc2.large"
  cluster_type       = "single-node"
  vpc_security_group_ids = ["${aws_security_group.redshift_sg.id}"]
  preferred_maintenance_window = "sun:20:00-sun:22:00"
  cluster_parameter_group_name = "${aws_redshift_parameter_group.redshift-reporting-timeout-pg.name}"
  publicly_accessible = "false"
  encrypted           = "false"
}

resource "aws_redshift_parameter_group" "redshift-reporting-timeout-pg" {
  name   = "redshift-reporting-with-timeout-${var.env}"
  family = "redshift-1.0"

  parameter {
    name  = "statement_timeout"
    value = "900000"
  }

}