//resource "aws_security_group" "redshift_sg" {
//  name = "redshift-sg"
//  vpc_id     = "${module.vpc.vpc_id}"
//  description = "redshift-sg"
//  ingress {
//    from_port   = 5439
//    to_port     = 5439
//    protocol    = "tcp"
//    cidr_blocks = ["${var.vpc_cidr}"]
//  }
//
//}
//
//
//resource "aws_redshift_subnet_group" "redshift_cluster_subnet_group" {
//  name       = "foo"
//  subnet_ids = ["${module.vpc.maintenance_subnet_id}"]
//}
//
//
//resource "aws_redshift_cluster" "report-redshift-cluster" {
//  count = "${var.report_redshift_required}"
//  cluster_identifier = "${var.env}-disha-report"
//  database_name      = "dev"
//  cluster_subnet_group_name = "${aws_redshift_subnet_group.redshift_cluster_subnet_group.name}"
//  master_username    = "smallvoldemort"
//  master_password    = "PlaceHolder123"
//  node_type          = "${var.report_redshift_type}"
//  cluster_type       = "single-node"
//  vpc_security_group_ids = ["${aws_security_group.redshift_sg.id}"]
//  preferred_maintenance_window = "sun:20:00-sun:22:00"
//  cluster_parameter_group_name = "${aws_redshift_parameter_group.redshift-timeout-pg.name}"
//  publicly_accessible = "false"
//  encrypted           = "false"
//}
//
//resource "aws_redshift_parameter_group" "redshift-timeout-pg" {
//  name   = "redshift-with-timeout"
//  family = "redshift-1.0"
//
//  parameter {
//    name  = "statement_timeout"
//    value = "${var.redshift_timeout_value}"
//  }
//
//}