module "lc-without-extra-ebs" {

  source = "../launch-configuration"
  count="${length(var.lc_ebs) > 0 ? 0 : 1 }"
  lc_ami          = "${var.lc_ami}"
  lc_instance_type     = "${var.lc_instance_type}"
  lc_sg   = ["${var.lc_sg}"]
  instance_authorization_key          = "${var.instance_authorization_key}"
  iam_instance_profile = "${var.iam_instance_profile}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  user_data = "${var.user_data}"
  app = "${var.as_name}"
  env = "${var.env}"
  ansible_public_key = "${var.ansible_public_key}"
}

module "lc-with-extra-ebs" {

  source = "../launch-configuration-special-disk"
  count="${length(var.lc_ebs) > 0 ? 1 : 0 }"
  lc_ami          = "${var.lc_ami}"
  lc_instance_type     = "${var.lc_instance_type}"
  lc_sg   = ["${var.lc_sg}"]
  instance_authorization_key          = "${var.instance_authorization_key}"
  iam_instance_profile = "${var.iam_instance_profile}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  user_data = "${var.user_data}"
  app = "${var.as_name}"
  env = "${var.env}"
  lc_ebs = "${var.lc_ebs}"
  ansible_public_key = "${var.ansible_public_key}"
  jenkins_public_key = "${var.jenkins_public_key}"
  stunServerAddress="${var.stunServerAddress}"
  stunServerPort="${var.stunServerPort}"
  turnURL="${var.turnURL}"
  turnURLPort="${var.turnURLPort}"
}


resource "aws_autoscaling_group" "as" {
  name                      = "${var.env}-${var.as_name}"
  max_size                  = "${var.as_max_size}"
  min_size                  = "${var.as_min_size}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  vpc_zone_identifier       = ["${var.as_subnet_id}"]
  launch_configuration      ="${coalesce(element(split(",", module.lc-without-extra-ebs.name), 0), element(split(",", module.lc-with-extra-ebs.name), 0))}"
  tag {
    key                 = "Name"
    value               = "${var.env}-${var.as_name}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Environment"
    value               = "${var.env}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Cluster"
    value               = "${format("%s", lower("${var.ag_instance_cluster_tag}"))}"
    propagate_at_launch = true
  }
}


resource "aws_autoscaling_attachment" "attach_alb_tg_to_asg" {
  count="${var.count_tg_attach}"
  autoscaling_group_name = "${aws_autoscaling_group.as.name}"
  alb_target_group_arn   = "${var.alb_tg_arn[count.index]}"
}
resource "aws_autoscaling_attachment" "attach_elb_to_asg" {
  count="${length(var.as_elb_name)}"
  autoscaling_group_name = "${aws_autoscaling_group.as.id}"
  elb                    = "${var.as_elb_name[count.index]}"
}

resource "aws_autoscaling_notification" "asg_notifications" {
  group_names = [
    "${aws_autoscaling_group.as.name}"
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR"

  ]

  topic_arn = "${var.sns_arn}"
}





