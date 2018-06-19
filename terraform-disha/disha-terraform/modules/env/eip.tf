resource "aws_eip_association" "openvpn" {
  instance_id = "${aws_instance.openvpn-instance.id}"
  allocation_id = "${lookup(var.eips,"openvpn")}"
}

resource "aws_eip_association" "jump_box" {
  instance_id = "${module.jump_box.instance_id}"
  allocation_id = "${lookup(var.eips,"jump_box")}"
}

resource "aws_eip_association" "username" {
  instance_id = "${module.disha_location_instance.instance_id}"
  allocation_id = "${lookup(var.eips,"location")}"
}
resource "aws_eip_association" "jenkins" {
  instance_id = "${aws_instance.jenkins-ansible-instance.id}"
  allocation_id = "${lookup(var.eips,"jenkins")}"
}
resource "aws_eip_association" "eligibility" {
  instance_id = "${module.disha_eligibility_instance.instance_id}"
  allocation_id = "${lookup(var.eips,"eligibility")}"
}
resource "aws_eip_association" "certificate" {
  instance_id = "${module.certificate_instance.instance_id}"
  allocation_id = "${lookup(var.eips,"certificate")}"
}
resource "aws_eip_association" "web-tcmap" {
  instance_id = "${module.disha_web_tcmap_instance.instance_id}"
  allocation_id = "${lookup(var.eips,"web-tcmap")}"
}