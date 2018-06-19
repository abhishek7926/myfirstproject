module "redis_instance" {
  source                     = "../instance"
  instance_type              = "${var.redis_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "redis"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="6379"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Platform-Core-Server"
  alarm_notification_arn = "${module.platform_core_server_sns.sns_arn}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"

}
module "activemq_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.activemq_instance_type}"
  instance_ami_id            = "${var.aws_maintenance_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "activemq"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="61616"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8161"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }


  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Platform-Core-Server"
  alarm_notification_arn = "${module.platform_core_server_sns.sns_arn}"
  disk_paths="${var.activemq_disk_paths}"
}

module "activemq_volume_attach" {
  source                     = "../attach-empty-volume"
  volume_type = "gp2"
  size = "50"
  instance_id = "${module.activemq_instance.instance_id}"
  instance_name = "${module.activemq_instance.instance_name}"
  default_az = "${var.default_az}"
  device_name = "/dev/sdc"

}



module "nfs_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.nfs_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "nfs"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="2049"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Platform-Core-Server"
  alarm_notification_arn = "${module.platform_core_server_sns.sns_arn}"
  enable_monitoring="0"


}


module "offline_app_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.offline_app_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "offline-app"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="ingress"
      port="443"
      protocol="tcp"
      cidr="0.0.0.0/0"

    }

  ]
  instance_cluster_tag = "Platform"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"

}


module "prelogin_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.prelogin_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "prelogin"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="ingress"
      port="443"
      protocol="tcp"
      cidr="0.0.0.0/0"

    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}

module "360feedback_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.threesixtyfeedback_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "360Feedback"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8030"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}


module "adminpanel_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.adminpanel_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  additional_sg              = "${aws_security_group.application_sg.id}"

  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "adminpanel"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8030"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Platform"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"

}

module "corporate_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.corporate_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  additional_sg              = "${aws_security_group.application_sg.id}"

  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "corporate"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8050"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
instance_cluster_tag = "Platform"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"

}


module "certification_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.certification_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "certification"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8092"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="443"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}


module "grader_instance" {
  source                     = "../instance-without-special-sg"
  instance_type              = "${var.grader_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  common_sg              = "${aws_security_group.application_sg.id}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "grader"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"

  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Platform"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"

}

module "contest_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.contest_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "contest"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8030"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }
  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}


module "lms_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.lms_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "lms"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8010"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }
  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}
module "api_demo_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.api_demo_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "api-demo"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8010"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }
  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Apps"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}

module "hpe_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.hpe_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "hpe"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8050"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }
  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Apps"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}



module "accenture_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.accenture_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "accenture"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8040"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }
  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Apps"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}

module "streaming_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.streaming_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "streaming"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="443"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="ingress"
      port="1986"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
    type="ingress"
    port="1987"
    protocol="tcp"
    cidr="0.0.0.0/0"
    },
    {
    type="ingress"
    port="1988"
    protocol="tcp"
    cidr="0.0.0.0/0"
    }

]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Proctoring"
  alarm_notification_arn = "${module.proctoring_sns.sns_arn}"

}

module "chat_socket_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.chat_socket_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "chat-socket"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="1986"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="ingress"
      port="1987"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="ingress"
      port="1988"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="ingress"
      port="443"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Proctoring"
  alarm_notification_arn = "${module.proctoring_sns.sns_arn}"

}

module "chat_service_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.chat_service_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "chat-service"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8030"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }
  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Proctoring"
  alarm_notification_arn = "${module.proctoring_sns.sns_arn}"

}



module "duo_lingo_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.duo_lingo_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "duo-lingo"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8030"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }
  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Proctoring"
  alarm_notification_arn = "${module.proctoring_sns.sns_arn}"


}

module "notification_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.notification_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "notification"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8060"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },

    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Platform"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"


}
module "chat_activemq_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.chat_activemq_instance_type}"
  instance_ami_id            = "${var.aws_maintenance_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "chat-activemq"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="61616"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8161"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }


  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Platform-Core-Server"
  alarm_notification_arn = "${module.platform_core_server_sns.sns_arn}"
  disk_paths="${var.activemq_disk_paths}"


}
module "chat_activemq_volume_attach" {
  source                     = "../attach-empty-volume"
  volume_type = "gp2"
  size = "50"
  instance_id = "${module.chat_activemq_instance.instance_id}"
  instance_name = "${module.chat_activemq_instance.instance_name}"
  default_az = "${var.default_az}"
  device_name = "/dev/sdc"

}

module "client_api_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.client_api_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "client-api"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="ingress"
      port="443"
      protocol="tcp"
      cidr="0.0.0.0/0"

    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}

module "uber_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.uber_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "Uber"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8050"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}


module "chat_web_socket_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.chat_web_socket_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "Chat-web-socket"
  additional_sg		     = "${aws_security_group.application_sg.id},${aws_security_group.hazelcast.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8090"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}






module "feedback_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.feedback_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "Feedback"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8030"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}

module "test_notification_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.test_notification_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "Test-Notification"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8090"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}

module "intellisense_router" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.intellisense_router_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "intellisense-router"
  additional_sg          = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="9000"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}

module "intellisense_csharp" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.intellisense_csharp_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "intellisense-csharp"
  additional_sg          = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="2000"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}

module "intellisense_java" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.intellisense_java_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "intellisense-java"
  additional_sg          = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8095"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="9001"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="9002"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="9003"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="9004"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="9005"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }
  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}

module "intellisense_python" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.intellisense_python_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "intellisense-python"
  additional_sg          = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="3000"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}


//module "application_metrics_instance" {
//  source                     = "../instance"
//  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
//  instance_type              = "${var.application_metrics_instance_type}"
//  instance_ami_id            = "${var.aws_app_ami}"
//  instance_authorization_key = "${module.vpc.auth_id}"
//  instance_subnet_id         = "${module.vpc.application_subnet_id}"
//  instance_name              = "Application-Metrics"
//  additional_sg		     = "${aws_security_group.application_sg.id}"
//  vpc_id                     = "${module.vpc.vpc_id}"
//  env                        = "${var.env}"
//  enable_monitoring          = "${var.enable_monitoring}"
//  sg_rule=[
//    {
//      type="ingress"
//      port="80"
//      protocol="tcp"
//      cidr="${var.vpc_cidr}"
//    },
//    {
//      type="ingress"
//      port="443"
//      protocol="tcp"
//      cidr="${var.vpc_cidr}"
//    },
//    {
//      type="ingress"
//      port="8083"
//      protocol="tcp"
//      cidr="${var.vpc_cidr}"
//    },
//    {
//      type="ingress"
//      port="8086"
//      protocol="tcp"
//      cidr="${var.vpc_cidr}"
//    },
//    {
//      type="ingress"
//      port="8088"
//      protocol="tcp"
//      cidr="${var.vpc_cidr}"
//    }
//  ]
//  instance_cluster_tag = "Platform-Core-Server"
//  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
//  private_dns_zone_name      = "${var.private_dns_zone_name}"
//  alarm_notification_arn = "${module.platform_core_server_sns.sns_arn}"
//
//}


module "master-1-elasticsearch" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.master_1_elasticsearch_instance_type}"
  instance_ami_id            = "${var.aws_maintenance_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "master-1-elasticsearch"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="9200"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="9300"
      protocol="tcp"
      cidr="${var.vpc_cidr}"

    }
  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Question Services"
  alarm_notification_arn = "${module.question_services_sns.sns_arn}"
  disk_paths="${var.es_disk_paths}"


}

module "master-2-elasticsearch" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.master_2_elasticsearch_instance_type}"
  instance_ami_id            = "${var.aws_maintenance_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "master-2-elasticsearch"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="9200"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="9300"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }
  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Question Services"
  alarm_notification_arn = "${module.question_services_sns.sns_arn}"
  disk_paths="${var.es_disk_paths}"


}

module "master-3-elasticsearch" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.master_3_elasticsearch_instance_type}"
  instance_ami_id            = "${var.aws_maintenance_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "master-3-elasticsearch"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="9200"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="9300"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }
  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Question Services"
  alarm_notification_arn = "${module.question_services_sns.sns_arn}"
  disk_paths="${var.es_disk_paths}"


}

module "data-1-elasticsearch" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.data_1_elasticsearch_instance_type}"
  instance_ami_id            = "${var.aws_maintenance_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "data-1-elasticsearch"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="9200"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="9300"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }
  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Question Services"
  alarm_notification_arn = "${module.question_services_sns.sns_arn}"
  disk_paths="${var.es_disk_paths}"


}
module "data-2-elasticsearch" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.data_2_elasticsearch_instance_type}"
  instance_ami_id            = "${var.aws_maintenance_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "data-2-elasticsearch"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="9200"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="9300"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }
  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Question Services"
  alarm_notification_arn = "${module.question_services_sns.sns_arn}"
  disk_paths="${var.es_disk_paths}"


}

module "master-1-elasticsearch-volume-attach" {
  source                     = "../attach-empty-volume"
  volume_type = "gp2"
  size = "20"
  instance_id = "${module.master-1-elasticsearch.instance_id}"
  instance_name = "${module.master-1-elasticsearch.instance_name}"
  default_az = "${var.default_az}"
  device_name = "/dev/sdc"

}
module "master-2-elasticsearch-volume-attach" {
  source                     = "../attach-empty-volume"
  volume_type = "gp2"
  size = "20"
  instance_id = "${module.master-2-elasticsearch.instance_id}"
  instance_name = "${module.master-2-elasticsearch.instance_name}"
  default_az = "${var.default_az}"
  device_name = "/dev/sdc"

}
module "master-3-elasticsearch-volume-attach" {
  source                     = "../attach-empty-volume"
  volume_type = "gp2"
  size = "20"
  instance_id = "${module.master-3-elasticsearch.instance_id}"
  instance_name = "${module.master-3-elasticsearch.instance_name}"
  default_az = "${var.default_az}"
  device_name = "/dev/sdc"

}
module "data-1-elasticsearch-volume-attach" {
  source                     = "../attach-empty-volume"
  volume_type = "gp2"
  size = "200"
  instance_id = "${module.data-1-elasticsearch.instance_id}"
  instance_name = "${module.data-1-elasticsearch.instance_name}"
  default_az = "${var.default_az}"
  device_name = "/dev/sdc"

}
module "data-2-elasticsearch-volume-attach" {
  source                     = "../attach-empty-volume"
  volume_type = "gp2"
  size = "200"
  instance_id = "${module.data-2-elasticsearch.instance_id}"
  instance_name = "${module.data-2-elasticsearch.instance_name}"
  default_az = "${var.default_az}"
  device_name = "/dev/sdc"

}

module "interviewApp_admin_frontend" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.interviewApp_admin_frontend_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "interviewApp-admin-frontend"
  additional_sg          = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}

module "interviewApp_admin_backend" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.interviewApp_admin_backend_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "interviewApp-admin-backend"
  additional_sg          = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8084"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}

module "interviewApp_candidate_frontend" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.interviewApp_candidate_frontend_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "interviewApp-candidate-frontend"
  additional_sg          = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}

module "interviewApp_candidate_backend" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.interviewApp_candidate_backend_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "interviewApp-candidate-backend"
  additional_sg          = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8083"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}

module "interviewApp_socket" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.interviewApp_socket_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "interviewApp-socket"
  additional_sg          = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="ingress"
      port="443"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="ingress"
      port="8082"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}

module "status_mettl" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.status_mettl_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "status-mettl"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="ingress"
      port="443"
      protocol="tcp"
      cidr="0.0.0.0/0"

    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"

}

module "labs_api" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.labs_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "labs-api"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="ingress"
      port="443"
      protocol="tcp"
      cidr="0.0.0.0/0"

    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"

}

module "labs_1_backend" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.labs_1_backend_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "labs-1-backend"
  additional_sg          = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  disk_paths = "${var.labs_backend_disk_paths}"

  sg_rule=[
    {
      type="ingress"
      port="8000"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8787"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8095"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}

module "labs_2_backend" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.labs_2_backend_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "labs-2-backend"
  additional_sg          = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  disk_paths = "${var.labs_backend_disk_paths}"

  sg_rule=[
    {
      type="ingress"
      port="8000"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8787"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8095"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }


  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"

}
module "labs-1-backend-volume-attach" {
  source                     = "../attach-empty-volume"
  volume_type = "gp2"
  size = "200"
  instance_id = "${module.labs_1_backend.instance_id}"
  instance_name = "${module.labs_1_backend.instance_name}"
  default_az = "${var.default_az}"
  device_name = "/dev/sdh"

}
module "labs-2-backend-volume-attach" {
  source                     = "../attach-empty-volume"
  volume_type = "gp2"
  size = "200"
  instance_id = "${module.labs_2_backend.instance_id}"
  instance_name = "${module.labs_2_backend.instance_name}"
  default_az = "${var.default_az}"
  device_name = "/dev/sdh"

}


module "Jobvite_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.jobvite_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "jobvite"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="ingress"
      port="443"
      protocol="tcp"
      cidr="0.0.0.0/0"

    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"

}

module "client_archival" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.client_archival_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "client_archival"
  additional_sg          = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8080"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Platform"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"

}

module "mongo_client_archival" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.mongo_client_archival_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "mongo_client_archival"
  additional_sg          = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8080"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  instance_cluster_tag = "Platform"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"

}
module "almdigital_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.almdigital_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "almdigital"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="ingress"
      port="443"
      protocol="tcp"
      cidr="0.0.0.0/0"

    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"

}

module "hackathon" {
  source = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type = "${var.hackathon_instance_type}"
  instance_ami_id = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id = "${module.vpc.public_subnet_id}"
  instance_name = "hackathon"
  additional_sg = "${aws_security_group.application_sg.id}"
  vpc_id = "${module.vpc.vpc_id}"
  env = "${var.env}"
  enable_monitoring = "${var.enable_monitoring}"
  sg_rule = [
    {
      type = "ingress"
      port = "80"
      protocol = "tcp"
      cidr = "0.0.0.0/0"
    },
    {
      type = "ingress"
      port = "443"
      protocol = "tcp"
      cidr = "0.0.0.0/0"

    }

  ]
  instance_cluster_tag = "Apps"
  private_route53_zone_id = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name = "${var.private_dns_zone_name}"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"

}
