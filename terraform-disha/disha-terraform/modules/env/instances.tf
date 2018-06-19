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
  instance_cluster_tag = "Platform-Core-Server"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"

}

module "disha_web_tcmap_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.disha_web_tcmap_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "web-tcmap"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="443"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8090"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Disha-web-Server"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"

}

module "disha_mongo_primary_instance" {
  source = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type = "${var.disha_mongo_primary_instance_type}"
  instance_ami_id = "${var.aws_mongo_primary_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id = "${module.vpc.application_subnet_id}"
  instance_name = "mongo-primary"
  additional_sg = "${aws_security_group.application_sg.id}"
  vpc_id = "${module.vpc.vpc_id}"
  env = "${var.env}"
  enable_monitoring = "${var.enable_monitoring}"
  sg_rule = [
    {
      type = "ingress"
      port = "27017"
      protocol = "tcp"
      cidr = "${var.vpc_cidr}"
    }
  ]
  private_route53_zone_id = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Disha-Mongo"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"
}

module "disha_mongo_secondary_instance" {
  source = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type = "${var.disha_mongo_secondary_instance_type}"
  instance_ami_id = "${var.aws_mongo_secondary_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id = "${module.vpc.application_subnet_id}"
  instance_name = "mongo-secondary"
  additional_sg = "${aws_security_group.application_sg.id}"
  vpc_id = "${module.vpc.vpc_id}"
  env = "${var.env}"
  enable_monitoring = "${var.enable_monitoring}"
  sg_rule = [
    {
      type = "ingress"
      port = "27017"
      protocol = "tcp"
      cidr = "${var.vpc_cidr}"
    }
  ]
  private_route53_zone_id = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Disha-Mongo"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"
}

module "disha_mongo_arbiter_instance" {
  source = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type = "${var.disha_mongo_arbiter_instance_type}"
  instance_ami_id = "${var.aws_mongo_arbiter_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id = "${module.vpc.application_subnet_id}"
  instance_name = "mongo-arbiter"
  additional_sg = "${aws_security_group.application_sg.id}"
  vpc_id = "${module.vpc.vpc_id}"
  env = "${var.env}"
  enable_monitoring = "${var.enable_monitoring}"
  sg_rule = [
    {
      type = "ingress"
      port = "27017"
      protocol = "tcp"
      cidr = "${var.vpc_cidr}"
    }
  ]
  private_route53_zone_id = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Disha-Mongo"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"
}

module "username_disha_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.username_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "username"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  instance_ebs_optimized     = "${var.username_instance_ebs_optimized}"
  sg_rule=[
    {
      type="ingress"
      port="8041"
      protocol="tcp"
      cidr="${var.vpc_cidr}"

    }

  ]
  instance_cluster_tag = "Disha"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"

}

module "disha_ifsc_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.disha_ifsc_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "ifsc"
  additional_sg		     = "${aws_security_group.application_sg.id}"
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
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Disha"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"

}

module "disha_eligibility_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.disha_eligibility_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "eligibility"
  additional_sg		     = "${aws_security_group.application_sg.id}"
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
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Disha"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"

}

module "disha_eligibility_additional_ebs" {
  source = "../attach-empty-volume"
  size = "200"
  default_az = "${module.disha_eligibility_instance.instance_az}"
  instance_id = "${module.disha_eligibility_instance.instance_id}"
  device_name = "/dev/sdc"
  volume_type = "gp2"
  instance_name = "${module.disha_eligibility_instance.instance_name}"
}

module "disha_location_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.disha_location_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "location"
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
    },
    {
      type="ingress"
      port="8080"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="egress"
      port="0"
      protocol="-1"
      cidr="0.0.0.0/0"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Disha"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"


}

module "pmgdisha_info_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.pmgdisha_info_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "pmgdisha_info"
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
    },
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Disha"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"


}

module "biometric" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.biometric_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "biometric"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
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
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Disha"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"


}

module "biometric_admin" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.biometric_admin_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "biometric-admin"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
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
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Disha"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"


}

module "certificate_instance" {
  source                     = "../instance"
  instance_iam_profile       = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.certificate_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.public_subnet_id}"
  instance_name              = "certificate"
  additional_sg		         = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="443"
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
  instance_cluster_tag = "Disha"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"


}

module "reporting_database_updator_instance" {
source                     = "../instance-without-special-sg"
instance_iam_profile       = "${aws_iam_instance_profile.report-db-updator-instance-profile.id}"
instance_type              = "${var.reporting_database_updator_instance_type}"
instance_ami_id            = "${var.aws_app_ami}"
instance_authorization_key = "${module.vpc.auth_id}"
instance_subnet_id         = "${module.vpc.application_subnet_id}"
instance_name              = "reporting-database-updator"
common_sg		           = "${aws_security_group.application_sg.id}"
env                        = "${var.env}"
enable_monitoring          = "${var.enable_monitoring}"
private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
instance_cluster_tag = "Disha"
alarm_notification_arn = "${module.disha_sns.sns_arn}"
}

module "metabase_instance" {
  source                     = "../instance"
  instance_iam_profile       = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.metabase_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "metabase"
  additional_sg		         = "${aws_security_group.application_sg.id}"
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
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Disha"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"


}

module "practice_instance" {
  source                     = "../instance"
  instance_iam_profile       = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.practice_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "practice"
  additional_sg		         = "${aws_security_group.application_sg.id}"
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
  instance_cluster_tag = "Disha"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"


}

module "circuit_breaker_instance" {
  source                     = "../instance"
  instance_iam_profile       = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.circuit_breaker_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "circuit-breaker"
  additional_sg		         = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8080"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }
  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Disha"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"


}

module "disha_cms_wordpress_instance" {
  source                     = "../instance"
  instance_iam_profile       = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.cms_wordpress_instance_type}"
  instance_ami_id            = "${var.cms_wordpress_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "cms-wordpress"
  additional_sg		         = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="80"
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
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Disha"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"
}
module "data-processing-engine" {
  source                     = "../instance"
  instance_iam_profile       = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.data-processing-engine_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "data-processing-engine"
  additional_sg		         = "${aws_security_group.application_sg.id}"
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
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  instance_cluster_tag = "Disha"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"


}