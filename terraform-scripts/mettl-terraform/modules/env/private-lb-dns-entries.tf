
resource "aws_route53_record" "ucl_codelysis_android_lb_route53_entry" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name    = "ucl-codelysis-android"
  type    = "A"

  alias {
    name                   = "${module.ucl-codelysis-android.elb_dns_name_output}"
    zone_id                = "${module.ucl-codelysis-android.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ucl_codelysis_lb_route53_entry" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name    = "ucl-codelysis"
  type    = "A"

  alias {
    name                   = "${module.ucl-codelysis.elb_dns_name_output}"
    zone_id                = "${module.ucl-codelysis.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ucl_codelysis_revert_lb_route53_entry" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name    = "ucl-codelysis-revert"
  type    = "A"

  alias {
    name                   = "${module.ucl-codelysis-revert-plan.elb_dns_name_output}"
    zone_id                = "${module.ucl-codelysis-revert-plan.elb_zone_id_output}"
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "ucl_code_project_lb_route53_entry" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name    = "ucl-code-project"
  type    = "A"

  alias {
    name                   = "${module.ucl-code-project.elb_dns_name_output}"
    zone_id                = "${module.ucl-code-project.elb_zone_id_output}"
    evaluate_target_health = true
  }
}


//resource "aws_route53_record" "chatweb_socket_lb_route53_entry" {
//  zone_id = "${module.vpc.private_route53_zone_id}"
//  name    = "chatweb-socket"
//  type    = "A"
//
//  alias {
//    name                   = "${module.chatweb-socket.elb_dns_name_output}"
//    zone_id                = "${module.chatweb-socket.elb_zone_id_output}"
//    evaluate_target_health = true
//  }
//}
resource "aws_route53_record" "java_codelysis_lb_route53_entry" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name    = "java-codelysis"
  type    = "A"

  alias {
    name                   = "${module.java-codelysis.elb_dns_name_output}"
    zone_id                = "${module.java-codelysis.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "proctoring_ui_lb_pvt_route53_entry" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name    = "proctoring-ui"
  type    = "A"

  alias {
    name                   = "${module.proctoring-ui.elb_dns_name_output}"
    zone_id                = "${module.proctoring-ui.elb_zone_id_output}"
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "report_ui_lb_pvt_route53_entry" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name    = "report-ui"
  type    = "A"

  alias {
    name                   = "${module.report-ui.elb_dns_name_output}"
    zone_id                = "${module.report-ui.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "cos_api_lb_pvt_route53_entry" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name    = "cos-api"
  type    = "A"

  alias {
    name                   = "${module.cos-api.elb_dns_name_output}"
    zone_id                = "${module.cos-api.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "redis_cache_pvt_route53_entry" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  ttl=10
  name    = "redis-user-session"
  type    = "CNAME"
  records        = ["${aws_elasticache_cluster.redis_cluster.cache_nodes.0.address}"]


}

resource "aws_route53_record" "redshift_report_pvt_route53_entry" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  ttl=10
  name    = "redshift-report"
  type    = "CNAME"
  records        = ["${aws_redshift_cluster.report-redshift-cluster.endpoint}"]


}
resource "aws_route53_record" "report_service_api_lb_pvt_route53_entry" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name    = "report-service-api"
  type    = "A"

  alias {
    name                   = "${module.report-service-api.elb_dns_name_output}"
    zone_id                = "${module.report-service-api.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "assessment_service_api_lb_pvt_route53_entry" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name    = "assessment-service-api"
  type    = "A"

  alias {
    name                   = "${module.assessment-service.elb_dns_name_output}"
    zone_id                = "${module.assessment-service.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "qs_lb_pvt_route53_entry" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name = "question-service"
  type = "A"

  alias {
    name = "${module.question-service.elb_dns_name_output}"
    zone_id = "${module.question-service.elb_zone_id_output}"
    evaluate_target_health = true
  }

}


resource "aws_route53_record" "spi_lb_route53_entry" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name    = "spi"
  type    = "A"

  alias {
    name                   = "${module.r-simulator-spi.elb_dns_name_output}"
    zone_id                = "${module.r-simulator-spi.elb_zone_id_output}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "plagiarism_lb_pvt_route53_entry" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name    = "plagiarism"
  type    = "A"

  alias {
    name                   = "${module.plagiarism.elb_dns_name_output}"
    zone_id                = "${module.plagiarism.elb_zone_id_output}"
    evaluate_target_health = true
  }
}