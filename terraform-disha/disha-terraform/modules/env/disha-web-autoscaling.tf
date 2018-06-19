module "disha-web" {
  source                    = "../autoscaling"
  aws_region		    = "${var.aws_region}"
  instance_authorization_key="${module.vpc.auth_id}"
  ansible_public_key = "${var.ansible_pub_key}"
  jenkins_public_key = "${var.jenkins_pub_key}"
  as_name                   = "web"
  count_tg_attach = "2"
  alb_tg_arn = ["${module.disha-app-tg-http.alb_tg_arn}","${module.disha-app-tg-https.alb_tg_arn}"]
  sns_arn  ="${module.disha_sns.sns_arn}"
  env="${var.env}"
  lc_ami                        = "${lookup(var.disha_web,"lc_ami")}"
  lc_instance_type              = "${lookup(var.disha_web,"lc_instance_type")}"
  user_data                     = "${lookup(var.disha_web,"user_data_file_name")}"
  as_max_size                   = "${lookup(var.disha_web,"as_max_size")}"
  as_min_size                   = "${lookup(var.disha_web,"as_min_size")}"
  # as_desired_size               = "${lookup(var.disha_web,"as_desired_size")}"
  as_default_cooldown           = "${lookup(var.disha_web,"as_default_cooldown")}"
  health_check_grace_period     = "${lookup(var.disha_web,"health_check_grace_period")}"
  health_check_type             = "${lookup(var.disha_web,"health_check_type")}"
  iam_instance_profile = "${aws_iam_instance_profile.autoscaling-deployment-s3logs-iam-profile.id}"

  disk_paths                = "${var.disha_web_disk_paths}"
  lc_sg                     = ["${aws_security_group.application_sg.id}","${aws_security_group.disha-web-sg.id}"]
  as_subnet_id		    = "${module.vpc.application_subnet_id}"
  ag_instance_cluster_tag = "Proctoring"


  enable_monitoring="${var.enable_monitoring}"
}


#######CREATE SG##########


resource "aws_security_group" "disha-web-sg" {
  name = "${var.env}-web-sg"
  description = "disha-web"
  vpc_id = "${module.vpc.vpc_id}"
  ingress {
    from_port =80
    to_port =80
    protocol = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]        }

  ingress{
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }
  ingress{
    from_port   = 8090
    to_port     = 8090
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  tags {
    Name = "${var.env}-web-sg"


  }

}
