resource "aws_launch_configuration" "lc-special-disk" {
  count="${var.count}"
  name              = "${var.env}-${var.app}"
  image_id          = "${var.lc_ami}"
  instance_type     = "${var.lc_instance_type}"
  security_groups   = ["${var.lc_sg}"]
  enable_monitoring = false
  key_name          = "${var.instance_authorization_key}"
  user_data         =  "${data.template_file.userdata_as_template.rendered}"
  iam_instance_profile = "${var.iam_instance_profile}"
  enable_monitoring = true
  associate_public_ip_address = "${var.associate_public_ip_address}"
  ebs_block_device{
    device_name = "${lookup(var.lc_ebs[count.index],"device_name")}",
    volume_size = "${lookup(var.lc_ebs[count.index],"volume_size")}",
    volume_type = "${lookup(var.lc_ebs[count.index],"volume_type")}",


//    "${var.lc_ebs[2]}"
  }

}
data "template_file" "userdata_as_template" {
  count="${var.count}"
  template = "${file(var.user_data)}"
  vars {
    deployement_env = "${var.env}"
    ansible_public_key = "${var.ansible_public_key}"
    jenkins_public_key = "${var.jenkins_public_key}"
    deployement_env = "${var.env}"
    stunServerAddress="${var.stunServerAddress}"
    stunServerPort="${var.stunServerPort}"
    turnURL="${var.turnURL}"
    turnURLPort="${var.turnURLPort}"
  }
}