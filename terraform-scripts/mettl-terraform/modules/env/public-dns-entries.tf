resource "aws_route53_record" "prelogin_instance_route53_entry" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = ""
  type       = "A"
  ttl        = "60"
  records    = ["${aws_eip_association.mettl_prelogin.public_ip}"]
}

resource "aws_route53_record" "www_cname_route53_entry" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "www"
  type       = "CNAME"
  ttl        = "60"
  records    = ["${var.public_dns_zone_name}"]
}

resource "aws_route53_record" "mobileapp_instance_route53_entry" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "mobileapp"
  type       = "A"
  ttl        = "60"
  records    = ["${aws_eip_association.offline_app.public_ip}"]
}

resource "aws_route53_record" "api_gateway_lb_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = "api"
  type    = "A"

  alias {
    name                   = "${module.mettl-api-gateway.elb_dns_name_output}"
    zone_id                = "${module.mettl-api-gateway.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "internal_api_lb_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = "internal-api"
  type    = "A"
  alias {
    name                   = "${module.mettl-api.elb_dns_name_output}"
    zone_id                = "${module.mettl-api.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "chat_instance_route53_entry" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "chat"
  type       = "A"
  ttl        = "60"
  records    = ["${aws_eip_association.chat_socket.public_ip}"]
}

resource "aws_route53_record" "reporting_metabase_route53_entry" {
  count = "${var.reporting_metabase_count}"
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "analytics"
  type       = "A"
  ttl        = "60"
  records    = ["${aws_eip_association.reporting_metabase.public_ip}"]
}

resource "aws_route53_record" "streaming_instance_route53_entry" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "streaming"
  type       = "A"
  ttl        = "60"
  records    = ["${aws_eip_association.streaming.public_ip}"]
}
resource "aws_route53_record" "vpn_instance_route53_entry" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "vpn"
  type       = "A"
  ttl        = "60"
  records    = ["${aws_eip_association.openvpn.public_ip}"]
}
resource "aws_route53_record" "labs_api_instance_route53_entry" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "labs"
  type       = "A"
  ttl        = "60"
  records    = ["${aws_eip_association.labs-api.public_ip}"]
}

resource "aws_route53_record" "tests_lb_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = "tests"
  type    = "A"

  alias {
    name                   = "${module.aui.elb_dns_name_output}"
    zone_id                = "${module.aui.elb_zone_id_output}"
    evaluate_target_health = true
  }
}



resource "aws_route53_record" "coding_simulators_lb_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = "codingsimulators"
  type    = "A"

  alias {
    name                   = "${module.coding-simulator.elb_dns_name_output}"
    zone_id                = "${module.coding-simulator.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "proxy_lb_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = "*"
  type    = "A"

  alias {
    name                   = "${module.proxy.elb_dns_name_output}"
    zone_id                = "${module.proxy.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "wipro_api_route53_entry" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "wiproapi"
  type       = "A"
  ttl        = "60"
  records    = ["${aws_eip_association.client-api.public_ip}"]
}

resource "aws_route53_record" "zydus_api_route53_entry" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "zydusapi"
  type       = "A"
  ttl        = "60"
  records    = ["${aws_eip_association.client-api.public_ip}"]
}

resource "aws_route53_record" "proctoring_ui_lb_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = "proctoring"
  type    = "A"

  alias {
    name                   = "${module.proctoring-ui.elb_dns_name_output}"
    zone_id                = "${module.proctoring-ui.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "pr_lb_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = "pr"
  type    = "A"

  alias {
    name                   = "${module.partial-response.elb_dns_name_output}"
    zone_id                = "${module.partial-response.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "jobvite_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name = "jobvite"
  type = "A"
  ttl = "60"
  records = [
    "${aws_eip_association.jobvite.public_ip}"]
}

resource "aws_route53_record" "interview_socket_route53_entry" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "interview-socket"
  type       = "A"
  ttl        = "60"
  records    = ["${aws_eip_association.interview-socket.public_ip}"]
}


resource "aws_route53_record" "r_simulators_socket_lb_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = "socket"
  type    = "A"

  alias {
    name                   = "${module.r-socket.elb_dns_name_output}"
    zone_id                = "${module.r-socket.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "hackathon_route53_entry" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "hackathon"
  type       = "A"
  ttl        = "60"
  records    = ["${aws_eip_association.hackathon.public_ip}"]
}