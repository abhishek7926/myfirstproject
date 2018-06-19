module "disha-cms-wordpress-tg-http" {
  source                = "../target-group"
  alb_tg_name           = "cms-wordpress-http"
  alb_tg_port           = "80"
  alb_tg_protocol       = "HTTP"
  alb_tg_vpc_id         = "${module.vpc.vpc_id}"
  notification_sns_arn  = "${module.disha_sns.sns_arn}"
  env                   = "${var.env}"
  health_check = {
    health_check_protocol="HTTP"
    health_check_path   = "/"
    health_check_port   = "80"
    health_check_healthy_threshold = "2"
    health_check_unhealthy_threshold = "2"
    health_check_response_timeout = "60"
    health_check_interval = "70"
    health_check_success_codes = "200"
  }

}

module "disha-cms-wordpress-tg-https" {
  source                = "../target-group"
  alb_tg_name           = "cms-wordps-https"
  alb_tg_port           = "443"
  alb_tg_protocol       = "HTTPS"
  alb_tg_vpc_id         = "${module.vpc.vpc_id}"
  notification_sns_arn  = "${module.disha_sns.sns_arn}"
  env                   = "${var.env}"
  health_check = {
    health_check_protocol="HTTPS"
    health_check_path    = "/"
    health_check_port    = "443"
    health_check_healthy_threshold = "2"
    health_check_unhealthy_threshold = "2"
    health_check_response_timeout = "60"
    health_check_interval = "70"
    health_check_success_codes = "200"
  }

}

module "disha-app-tg-http" {
  source                = "../target-group"
  alb_tg_name           = "app-http"
  alb_tg_port           = "80"
  alb_tg_protocol       = "HTTP"
  alb_tg_vpc_id         = "${module.vpc.vpc_id}"
  notification_sns_arn  = "${module.disha_sns.sns_arn}"
  env                   = "${var.env}"
  health_check = {
    health_check_protocol="HTTP"
    health_check_path   = "/app/statusCheck"
    health_check_port   = "80"
    health_check_healthy_threshold = "2"
    health_check_unhealthy_threshold = "2"
    health_check_response_timeout = "5"
    health_check_interval = "10"
    health_check_success_codes = "301"
  }

}

module "disha-app-tg-https" {
  source                = "../target-group"
  alb_tg_name           = "app-https"
  alb_tg_port           = "443"
  alb_tg_protocol       = "HTTPS"
  alb_tg_vpc_id         = "${module.vpc.vpc_id}"
  notification_sns_arn  = "${module.disha_sns.sns_arn}"
  env                   = "${var.env}"
  health_check = {
    health_check_protocol="HTTPS"
    health_check_path   = "/app/statusCheck"
    health_check_port   = "443"
    health_check_healthy_threshold = "2"
    health_check_unhealthy_threshold = "2"
    health_check_response_timeout = "10"
    health_check_interval = "15"
    health_check_success_codes = "200"
  }

}

module "disha-app-tcmap-tg-http" {
  source                = "../target-group"
  alb_tg_name           = "tcmap-http"
  alb_tg_port           = "80"
  alb_tg_protocol       = "HTTP"
  alb_tg_vpc_id         = "${module.vpc.vpc_id}"
  notification_sns_arn  = "${module.disha_sns.sns_arn}"
  env                   = "${var.env}"
  health_check = {
    health_check_protocol="HTTP"
    health_check_path   = "/tcmap/statusCheck"
    health_check_port   = "80"
    health_check_healthy_threshold = "2"
    health_check_unhealthy_threshold = "2"
    health_check_response_timeout = "5"
    health_check_interval = "10"
    health_check_success_codes = "301"
  }

}

module "disha-app-tcmap-tg-https" {
  source                = "../target-group"
  alb_tg_name           = "tcmap-https"
  alb_tg_port           = "443"
  alb_tg_protocol       = "HTTPS"
  alb_tg_vpc_id         = "${module.vpc.vpc_id}"
  notification_sns_arn  = "${module.disha_sns.sns_arn}"
  env                   = "${var.env}"
  health_check = {
    health_check_protocol="HTTPS"
    health_check_path   = "/tcmap/statusCheck"
    health_check_port   = "443"
    health_check_healthy_threshold = "2"
    health_check_unhealthy_threshold = "2"
    health_check_response_timeout = "10"
    health_check_interval = "15"
    health_check_success_codes = "200"
  }

}

module "biometric-tg-http" {
  source                = "../target-group"
  alb_tg_name           = "biometric-http"
  alb_tg_port           = "80"
  alb_tg_protocol       = "HTTP"
  alb_tg_vpc_id         = "${module.vpc.vpc_id}"
  notification_sns_arn  = "${module.disha_sns.sns_arn}"
  env                   = "${var.env}"
  health_check = {
    health_check_protocol="HTTP"
    health_check_path   = "/ping"
    health_check_port   = "80"
    health_check_healthy_threshold = "2"
    health_check_unhealthy_threshold = "2"
    health_check_response_timeout = "5"
    health_check_interval = "10"
    health_check_success_codes = "200"
  }

}

module "biometric-tg-https" {
  source                = "../target-group"
  alb_tg_name           = "biometric-https"
  alb_tg_port           = "443"
  alb_tg_protocol       = "HTTPS"
  alb_tg_vpc_id         = "${module.vpc.vpc_id}"
  notification_sns_arn  = "${module.disha_sns.sns_arn}"
  env                   = "${var.env}"
  health_check = {
    health_check_protocol="HTTPS"
    health_check_path   = "/ping"
    health_check_port   = "443"
    health_check_healthy_threshold = "2"
    health_check_unhealthy_threshold = "2"
    health_check_response_timeout = "10"
    health_check_interval = "15"
    health_check_success_codes = "200"
  }

}

module "biometric-admin-tg-http" {
  source                = "../target-group"
  alb_tg_name           = "biom-admin-http"
  alb_tg_port           = "80"
  alb_tg_protocol       = "HTTP"
  alb_tg_vpc_id         = "${module.vpc.vpc_id}"
  notification_sns_arn  = "${module.disha_sns.sns_arn}"
  env                   = "${var.env}"
  health_check = {
    health_check_protocol="HTTP"
    health_check_path   = "/ping"
    health_check_port   = "80"
    health_check_healthy_threshold = "2"
    health_check_unhealthy_threshold = "2"
    health_check_response_timeout = "5"
    health_check_interval = "10"
    health_check_success_codes = "200"
  }

}

module "biometric-admin-tg-https" {
  source                = "../target-group"
  alb_tg_name           = "bio-admin-https"
  alb_tg_port           = "443"
  alb_tg_protocol       = "HTTPS"
  alb_tg_vpc_id         = "${module.vpc.vpc_id}"
  notification_sns_arn  = "${module.disha_sns.sns_arn}"
  env                   = "${var.env}"
  health_check = {
    health_check_protocol="HTTPS"
    health_check_path   = "/ping"
    health_check_port   = "443"
    health_check_healthy_threshold = "2"
    health_check_unhealthy_threshold = "2"
    health_check_response_timeout = "10"
    health_check_interval = "15"
    health_check_success_codes = "200"
  }

}

module "certificate-tg-https" {
  source                = "../target-group"
  alb_tg_name           = "certificate-https"
  alb_tg_port           = "443"
  alb_tg_protocol       = "HTTPS"
  alb_tg_vpc_id         = "${module.vpc.vpc_id}"
  notification_sns_arn  = "${module.disha_sns.sns_arn}"
  env                   = "${var.env}"
  health_check = {
    health_check_protocol="HTTPS"
    health_check_path   = "/login"
    health_check_port   = "443"
    health_check_healthy_threshold = "2"
    health_check_unhealthy_threshold = "2"
    health_check_response_timeout = "10"
    health_check_interval = "15"
    health_check_success_codes = "200"
  }

}

module "metabase-tg-http" {
  source                = "../target-group"
  alb_tg_name           = "metabase-http"
  alb_tg_port           = "8080"
  alb_tg_protocol       = "HTTP"
  alb_tg_vpc_id         = "${module.vpc.vpc_id}"
  notification_sns_arn  = "${module.disha_sns.sns_arn}"
  env                   = "${var.env}"
  health_check = {
    health_check_protocol="HTTP"
    health_check_path   = "/"
    health_check_port   = "8080"
    health_check_healthy_threshold = "2"
    health_check_unhealthy_threshold = "2"
    health_check_response_timeout = "10"
    health_check_interval = "15"
    health_check_success_codes = "200"
  }

}

module "practice-tg-http" {
  source                = "../target-group"
  alb_tg_name           = "practice-http"
  alb_tg_port           = "8040"
  alb_tg_protocol       = "HTTP"
  alb_tg_vpc_id         = "${module.vpc.vpc_id}"
  notification_sns_arn  = "${module.disha_sns.sns_arn}"
  env                   = "${var.env}"
  health_check = {
    health_check_protocol="HTTP"
    health_check_path   = "/statusCheck"
    health_check_port   = "8040"
    health_check_healthy_threshold = "2"
    health_check_unhealthy_threshold = "2"
    health_check_response_timeout = "10"
    health_check_interval = "15"
    health_check_success_codes = "200"
  }

}

module "turbine-tg-https" {
  source = "../target-group"
  alb_tg_name = "turbine-tg-https"
  alb_tg_port = "443"
  alb_tg_protocol = "HTTPS"
  alb_tg_vpc_id = "${module.vpc.vpc_id}"
  notification_sns_arn = "${module.disha_sns.sns_arn}"
  env = "${var.env}"
  health_check = {
    health_check_protocol = "HTTPS"
    health_check_path = "/"
    health_check_port = "443"
    health_check_healthy_threshold = "2"
    health_check_unhealthy_threshold = "2"
    health_check_response_timeout = "5"
    health_check_interval = "10"
    health_check_success_codes = "200"
  }
}

module "disha-cms-alb" {
  source                 = "../alb-http"
  alb_name               = "pmgdisha"
  alb_sg_id              = ["${aws_security_group.application_sg.id}","${aws_security_group.disha-cms-alb-sg.id}"]
  alb_subnets            = ["${module.vpc.public_subnet_id}","${module.vpc.additional_public_subnet_id}"]
  env  = "${var.env}"
  alb_logs               = {
//    alb_logs_interval    = "60"
    alb_logs_enabled     = "true"
  }

}

module "disha-cms-listener" {
  source                 = "../listener"
  alb_arn                = "${module.disha-cms-alb.alb_arn_output}"
  alb_tg_http_arn        = "${module.disha-cms-wordpress-tg-http.alb_tg_arn}"
  alb_tg_https_arn       = "${module.disha-cms-wordpress-tg-https.alb_tg_arn}"
  ssl_certificate_arn    = "${var.acm-arn}"
  additional_ssl_arn     = "${var.additional_ssl_arn}"

  listener_arn_http = "${module.disha-cms-listener.listener_http_arn}"
  base_priority_http = "100"
  count_rules_http = "5"
  rules_http=[
    {
      group_arn = "${module.biometric-tg-http.alb_tg_arn}"
      field = "host-header"
      value = "${var.biometric_subdomain}"
    },
    {
      group_arn = "${module.biometric-admin-tg-http.alb_tg_arn}"
      field = "host-header"
      value = "${var.biometric_admin_subdomain}"
    },
    {
      group_arn = "${module.practice-tg-http.alb_tg_arn}"
      field = "host-header"
      value = "${var.practice_subdomain}"
    },
    {
      group_arn = "${module.disha-app-tg-http.alb_tg_arn}"
      field = "path-pattern"
      value = "/app/*"
    },
    {
      group_arn = "${module.disha-app-tcmap-tg-http.alb_tg_arn}"
      field = "path-pattern"
      value = "/tcmap/*"
    }
  ]
  count_rules_https = "8"
  listener_arn_https = "${module.disha-cms-listener.listener_https_arn}"
  base_priority_https = "101"
  rules_https=[
    {
      group_arn = "${module.biometric-tg-https.alb_tg_arn}"
      field = "host-header"
      value = "${var.biometric_subdomain}"
    },
    {
      group_arn = "${module.biometric-admin-tg-https.alb_tg_arn}"
      field = "host-header"
      value = "${var.biometric_admin_subdomain}"
    },
    {
      group_arn = "${module.certificate-tg-https.alb_tg_arn}"
      field = "host-header"
      value = "${var.certificate_subdomain}"
    },
    {
      group_arn = "${module.metabase-tg-http.alb_tg_arn}"
      field = "host-header"
      value = "${var.reports_subdomain}"
    },
    {
      group_arn = "${module.practice-tg-http.alb_tg_arn}"
      field = "host-header"
      value = "${var.practice_subdomain}"
    },
    {
      group_arn = "${module.turbine-tg-https.alb_tg_arn}"
      field = "host-header"
      value = "${var.turbine_subdomain}"
    },
    {
      group_arn = "${module.disha-app-tg-https.alb_tg_arn}"
      field = "path-pattern"
      value = "/app/*"
    },
    {
      group_arn = "${module.disha-app-tcmap-tg-https.alb_tg_arn}"
      field = "path-pattern"
      value = "/tcmap/*"
    }

  ]

}

resource "aws_alb_target_group_attachment" "disha-cms-wordpress-http" {
  target_group_arn = "${module.disha-cms-wordpress-tg-http.alb_tg_arn}"
  target_id = "${module.disha_cms_wordpress_instance.instance_id}"
  port = 80
}

resource "aws_alb_target_group_attachment" "disha-cms-wordpress-https" {
  target_group_arn = "${module.disha-cms-wordpress-tg-https.alb_tg_arn}"
  target_id = "${module.disha_cms_wordpress_instance.instance_id}"
  port = 443
}

resource "aws_alb_target_group_attachment" "disha-tcmap-http" {
  target_group_arn = "${module.disha-app-tcmap-tg-http.alb_tg_arn}"
  target_id = "${module.disha_web_tcmap_instance.instance_id}"
  port = 80
}

resource "aws_alb_target_group_attachment" "disha-tcmap-https" {
  target_group_arn = "${module.disha-app-tcmap-tg-https.alb_tg_arn}"
  target_id = "${module.disha_web_tcmap_instance.instance_id}"
  port = 443
}

resource "aws_alb_target_group_attachment" "biometric-http" {
  target_group_arn = "${module.biometric-tg-http.alb_tg_arn}"
  target_id = "${module.biometric.instance_id}"
  port = 80
}

resource "aws_alb_target_group_attachment" "biometric-https" {
  target_group_arn = "${module.biometric-tg-https.alb_tg_arn}"
  target_id = "${module.biometric.instance_id}"
  port = 443
}

resource "aws_alb_target_group_attachment" "biometric-admin-http" {
  target_group_arn = "${module.biometric-admin-tg-http.alb_tg_arn}"
  target_id = "${module.biometric_admin.instance_id}"
  port = 80
}

resource "aws_alb_target_group_attachment" "biometric-admin-https" {
  target_group_arn = "${module.biometric-admin-tg-https.alb_tg_arn}"
  target_id = "${module.biometric_admin.instance_id}"
  port = 443
}


resource "aws_alb_target_group_attachment" "certificate-https" {
  target_group_arn = "${module.certificate-tg-https.alb_tg_arn}"
  target_id = "${module.certificate_instance.instance_id}"
  port = 443
}

resource "aws_alb_target_group_attachment" "metabase-https" {
  target_group_arn = "${module.metabase-tg-http.alb_tg_arn}"
  target_id = "${module.metabase_instance.instance_id}"
  port = 8080
}

resource "aws_alb_target_group_attachment" "practice-http" {
  target_group_arn = "${module.practice-tg-http.alb_tg_arn}"
  target_id = "${module.practice_instance.instance_id}"
  port = 8040
}

resource "aws_alb_target_group_attachment" "turbine-http" {
  target_group_arn = "${module.turbine-tg-https.alb_tg_arn}"
  target_id = "${module.circuit_breaker_instance.instance_id}"
  port = 443
}

resource "aws_security_group" "disha-cms-alb-sg" {
  name = "${var.env}-cms-alb-sg"
  description = "disha-cms"
  vpc_id = "${module.vpc.vpc_id}"
  ingress {
    from_port =80
    to_port =80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]        }

  ingress{
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.env}-cms-alb-sg"


  }

}
