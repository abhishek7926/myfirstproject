#module "fes_instance" {
#  source                     = "../instance-without-special-sg"
#  instance_type              = "${var.fes_instance_type}"
#  instance_ami_id            = "${var.aws_app_ami}"
#  common_sg              = "${aws_security_group.application_sg.id}"

#  instance_authorization_key = "${module.vpc.auth_id}"
#  instance_subnet_id         = "${module.vpc.application_subnet_id}"
#  instance_name              = "fes"

#  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
#  private_dns_zone_name      = "${var.private_dns_zone_name}"
#}

module "fes_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.fes_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "fes"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="9880"
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
  instance_cluster_tag = "Simulators"
  alarm_notification_arn = "${module.simulators_sns.sns_arn}"
  disk_paths           =  [
    {
      Filesystem="/dev/mapper/vg0-lv_root"
      MountPath="/"
    },
    {
      Filesystem="/dev/xvda1"
      MountPath="/boot"
    },
    {
      Filesystem="/dev/mapper/vg0-lv_mettl_volume1"
      MountPath="/home/mettl/volume1"
    },
    {
      Filesystem="/dev/mapper/vg0-lv_mettl_logs"
      MountPath="/home/mettl/mettl_logs"
    },
    {
      Filesystem="/dev/xvdh"
      MountPath="/data/fes"
    }

  ]
}


module "fes_volume_attach" {
  source                     = "../attach-copied-volume"
  snapshot_id ="${var.fes_snapshot_id}"
  default_az="${var.default_az}"
  instance_id="${module.fes_instance.instance_id}"
  device_name="/dev/sdh"
  volume_type="standard"
  instance_name = "${module.fes_instance.instance_name}"
}


module "static_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.static_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "static"
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
      port="9052"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Platform"
  alarm_notification_arn = "${module.platform_sns.sns_arn}"
disk_paths           =  [
{
Filesystem="/dev/mapper/vg0-lv_root"
MountPath="/"
},
{
Filesystem="/dev/xvda1"
MountPath="/boot"
},
{
Filesystem="/dev/mapper/vg0-lv_mettl_volume1"
MountPath="/home/mettl/volume1"
},
{
Filesystem="/dev/mapper/vg0-lv_mettl_logs"
MountPath="/home/mettl/mettl_logs"
},
{
Filesystem="/dev/xvdf"
MountPath="/data/www-data"
}

]



}

module "static_volume_attach" {
  source                     = "../attach-copied-volume"
  snapshot_id ="${var.static_snapshot_id}"
  default_az="${var.default_az}"
  instance_id="${module.static_instance.instance_id}"
  device_name="/dev/sdf"
  volume_type="standard"
instance_name = "${module.static_instance.instance_name}"
}

module "fhgfs_ucl_code_project_instance" {
  source                     = "../instance-with-generic-userdata"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.fhgfs_ucl_code_project_instance_type}"
  instance_ami_id            = "${var.aws_fhgfs_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "fhgfs-ucl-code-project"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
    {
      type="ingress"
      port="8003"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8004"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8005"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8006"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8007"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8008"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8003"
      protocol="udp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8004"
      protocol="udp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8005"
      protocol="udp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8006"
      protocol="udp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8007"
      protocol="udp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="8008"
      protocol="udp"
      cidr="${var.vpc_cidr}"
    }

  ]
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  ansible_pub_key = "${var.ansible_pub_key}"
  instance_cluster_tag = "Simulators"
  alarm_notification_arn = "${module.simulators_sns.sns_arn}"
  disk_paths           =  [

    {
    Filesystem="/dev/xvda1"
    MountPath="/"
    },
    {
Filesystem="/dev/xvdf"
MountPath="/data"
}



]


}

module "fhgfs_ucl_code_project_volume_attach" {
  source                     = "../attach-copied-volume"
  snapshot_id ="${var.fhgfs_ucl_code_project_snapshot_id}"
  default_az="${var.default_az}"
  instance_id="${module.fhgfs_ucl_code_project_instance.instance_id}"
  device_name="/dev/sdf"
  volume_type="standard"
instance_name = "${module.fhgfs_ucl_code_project_instance.instance_name}"
}


module "igt_instance" {
  source                     = "../instance"
  instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.igt_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "igt"
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
  instance_cluster_tag = "Apps"
  alarm_notification_arn = "${module.apps_sns.sns_arn}"
  disk_paths           =  [

{
Filesystem="/dev/mapper/vg0-lv_root"
MountPath="/"
},
{
Filesystem="/dev/xvda1"
MountPath="/boot"
},
{
Filesystem="/dev/mapper/vg0-lv_mettl_volume1"
MountPath="/home/mettl/volume1"
},
{
Filesystem="/dev/mapper/vg0-lv_mettl_logs"
MountPath="/home/mettl/mettl_logs"
},
    {
      Filesystem = "/dev/xvdc"
      MountPath = "/mnt/igt-data"
    }



]

}
module "igt_volume_attach" {
  source                     = "../attach-copied-volume"
  snapshot_id ="${var.igt_snapshot_id}"
  default_az="${var.default_az}"
  instance_id="${module.igt_instance.instance_id}"
  device_name="/dev/sdc"
  volume_type="standard"
  instance_name = "${module.igt_instance.instance_name}"
}

module "question_event_service_instance" {
  source                     = "../instance-without-special-sg"
  instance_iam_profile =  "${aws_iam_instance_profile.instance-profile.id}"
  instance_type              = "${var.question_event_service_instance_type}"
  instance_ami_id            = "${var.aws_app_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "question-event-service"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  common_sg = "${aws_security_group.application_sg.id}"
  private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
  private_dns_zone_name      = "${var.private_dns_zone_name}"
  instance_cluster_tag = "Question Services"
  alarm_notification_arn = "${module.question_services_sns.sns_arn}"
}
