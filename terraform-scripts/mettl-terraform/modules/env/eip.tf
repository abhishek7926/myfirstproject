resource "aws_eip_association" "mettl_prelogin" {
  instance_id = "${module.prelogin_instance.instance_id}"
  allocation_id = "${lookup(var.eips,"mettl_prelogin")}"
}

resource "aws_eip_association" "offline_app" {
  instance_id = "${module.offline_app_instance.instance_id}"
  allocation_id = "${lookup(var.eips,"offline_app")}"
}

//resource "aws_eip_association" "mettl_api" {
//  instance_id = "${module.api_instance.instance_id}"
//  allocation_id = "${lookup(var.eips,"mettl_api")}"
//}

resource "aws_eip_association" "streaming" {
  instance_id = "${module.streaming_instance.instance_id}"
  allocation_id = "${lookup(var.eips,"streaming")}"
}

resource "aws_eip_association" "chat_socket" {
  instance_id = "${module.chat_socket_instance.instance_id}"
  allocation_id = "${lookup(var.eips,"chat_socket")}"
}

resource "aws_eip_association" "reporting_metabase" {
  instance_id = "${module.reporting_metabase_instance.instance_id}"
  allocation_id = "${lookup(var.eips,"reporting_metabase")}"
}

resource "aws_eip_association" "jump_box" {
  instance_id = "${module.jump_box.instance_id}"
  allocation_id = "${lookup(var.eips,"jump_box")}"
}

resource "aws_eip_association" "openvpn" {
  instance_id = "${aws_instance.openvpn-instance.id}"
  allocation_id = "${lookup(var.eips,"openvpn")}"
}

resource "aws_eip_association" "client-api" {
  instance_id = "${module.client_api_instance.instance_id}"
  allocation_id = "${lookup(var.eips,"client-api")}"
}

resource "aws_eip_association" "status-mettl" {
  instance_id = "${module.status_mettl.instance_id}"
  allocation_id = "${lookup(var.eips,"status-mettl")}"
}

resource "aws_eip_association" "labs-api" {
  instance_id = "${module.labs_api.instance_id}"
  allocation_id = "${lookup(var.eips,"labs-api")}"
}

resource "aws_eip_association" "jobvite" {
  instance_id = "${module.Jobvite_instance.instance_id}"
  allocation_id = "${lookup(var.eips,"jobvite")}"
}

resource "aws_eip_association" "interview-socket" {
  instance_id = "${module.interviewApp_socket.instance_id}"
  allocation_id = "${lookup(var.eips,"interview-socket")}"
}

resource "aws_eip_association" "hackathon" {
  instance_id = "${module.hackathon.instance_id}"
  allocation_id = "${lookup(var.eips,"hackathon")}"
}

