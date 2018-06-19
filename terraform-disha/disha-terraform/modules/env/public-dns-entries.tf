resource "aws_route53_record" "vpn_instance_route53_entry" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "vpn"
  type       = "A"
  ttl        = "60"
  records    = ["${aws_eip_association.openvpn.public_ip}"]
}

resource "aws_route53_record" "jenkins_instance_route53_entry" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "jenkins"
  type       = "A"
  ttl        = "60"
  records    = ["${aws_eip_association.jenkins.public_ip}"]
}

resource "aws_route53_record" "location_instance_route53_entry" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "location"
  type       = "A"
  ttl        = "60"
  records    = ["${aws_eip_association.username.public_ip}"]
}

resource "aws_route53_record" "root_lb_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = ""
  type    = "A"

  alias {
    name                   = "${module.disha-cms-alb.alb_dns_output}"
    zone_id                = "${module.disha-cms-alb.alb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www_root_lb_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = "www"
  type    = "A"

  alias {
    name                   = "${module.disha-cms-alb.alb_dns_output}"
    zone_id                = "${module.disha-cms-alb.alb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "csc_gov_lb_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = "csc-gov"
  type    = "A"

  alias {
    name                   = "${module.disha-cms-alb.alb_dns_output}"
    zone_id                = "${module.disha-cms-alb.alb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "admin_csc_gov_lb_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = "admin.csc-gov"
  type    = "A"

  alias {
    name                   = "${module.disha-cms-alb.alb_dns_output}"
    zone_id                = "${module.disha-cms-alb.alb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "certificate_lb_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = "certificate"
  type    = "A"

  alias {
    name                   = "${module.disha-cms-alb.alb_dns_output}"
    zone_id                = "${module.disha-cms-alb.alb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "info_lb_route53_entry" {
  count   = "${var.is_info_new_domain ? 0 : 1}"
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = "pmgdisha"
  type    = "A"

  alias {
    name                   = "${module.as-lb-http.elb_dns_name_output}"
    zone_id                = "${module.as-lb-http.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "info_lb_new_dns_route53_entry" {
  count   = "${var.is_info_new_domain ? 1 : 0}"
  zone_id = "${module.vpc.public_route53_info_zone_id}"
  name    = ""
  type    = "A"

  alias {
    name                   = "${module.as-lb-http.elb_dns_name_output}"
    zone_id                = "${module.as-lb-http.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "metabase_lb_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = "reports"
  type    = "A"

  alias {
    name                   = "${module.disha-cms-alb.alb_dns_output}"
    zone_id                = "${module.disha-cms-alb.alb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "practice_lb_route53_entry" {
  zone_id = "${module.vpc.public_route53_zone_id}"
  name    = "practice"
  type    = "A"

  alias {
    name                   = "${module.disha-cms-alb.alb_dns_output}"
    zone_id                = "${module.disha-cms-alb.alb_zone_id_output}"
    evaluate_target_health = true
  }
}