resource "aws_launch_configuration" "lc" {
  count="${var.count}"
  name_prefix              = "${format("%s", lower("${var.app}-LC.${var.private_dns_zone_name}"))}"
  image_id          = "${var.lc_ami}"
  instance_type     = "${var.lc_instance_type}"
  security_groups   = ["${var.lc_sg}"]
  enable_monitoring = false
  key_name          = "${var.instance_authorization_key}"
  user_data         =  "${data.template_file.userdata_as_template.rendered}"
  iam_instance_profile = "${var.iam_instance_profile}"
  enable_monitoring = true
  associate_public_ip_address = "${var.associate_public_ip_address}"

  lifecycle {
    create_before_destroy = true
  }

}
data "template_file" "userdata_as_template" {
  count="${var.count}"
  template = "${file(var.user_data)}"
  vars {
    deployement_env = "${var.env}"
    ansible_public_key = "${var.ansible_public_key}"
    deployement_env = "${var.env}"
    stunServerAddress="${var.stunServerAddress}"
    stunServerPort="${var.stunServerPort}"
    turnURL="${var.turnURL}"
    turnURLPort="${var.turnURLPort}"
    jenkins_public_key = "${var.jenkins_public_key}"

  }
}