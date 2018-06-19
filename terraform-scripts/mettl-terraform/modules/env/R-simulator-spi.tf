module "r-simulator-spi" {
  source = "./../autoscaling-with-lb-tcp-listener"
  private_dns_zone_name="${var.private_dns_zone_name}"
  env="${var.env}"
  aws_region="${var.aws_region}"
  lc_ami                        = "${lookup(var.r-simulator-spi,"lc_ami")}"
  lc_instance_type              = "${lookup(var.r-simulator-spi,"lc_instance_type")}"
  user_data                     = "../documents/userdata/autoscaling/r-simulator-spi-userdata"
  as_max_size                   = "${lookup(var.r-simulator-spi,"as_max_size")}"
  as_min_size                   = "${lookup(var.r-simulator-spi,"as_min_size")}"
  # as_desired_size               = "${lookup(var.r-simulator-spi,"as_desired_size")}"
  as_default_cooldown           = "${lookup(var.r-simulator-spi,"as_default_cooldown")}"
  health_check_grace_period     = "${lookup(var.r-simulator-spi,"health_check_grace_period")}"
  health_check_type             = "${lookup(var.r-simulator-spi,"health_check_type")}"
  notification_sns_arn  ="${module.simulators_sns.sns_arn}"
  as_notification_sns_arn = "${module.simulators_as_sns.sns_arn}"

  #elb_logs_bucket=""  # instead of variable use env and rest hardcode
  #elb_logs_folder=""
  iam_instance_profile = "${aws_iam_instance_profile.autoscaling-deployment-s3logs-iam-profile.id}"

  instance_authorization_key       = "${module.vpc.auth_id}"
  as_subnet_id                     = "${module.vpc.application_subnet_id}"
  lc_sg                            = ["${aws_security_group.application_sg.id}","${module.spi_elb_sg.sg_id}","${aws_security_group.r-simulator-hazelcast.id}"]
  as_name                          = "r-simulator-spi"
  elb_subnet                       = "${module.vpc.application_subnet_id}"
  elb_sg_id                        = "${module.spi_elb_sg.sg_id}"
  listener=[
    {
      listener_instance_port="10002"
      listener_instance_protocol="TCP"
      listener_lb_port="10002"
      listener_lb_protocol="TCP"
    }

  ]

  health_check={
    health_check_healthy_threshold   = "2"
    health_check_unhealthy_threshold = "2"
    health_check_target              = "HTTP:10002/ping"
    health_check_response_timeout = "9"
    health_check_interval         = "10"

  }
  elb_idle_timeout =  "${lookup(var.r-simulator-spi,"elb_idle_timeout")}"
  elb_connection_draining = {

    set_connection_draining="${lookup(var.r-simulator-spi,"set_connection_draining")}"
    connection_draining_timeout="${lookup(var.r-simulator-spi,"connection_draining_timeout")}"


  }
  elb_logs = {
    elb_logs_interval = "60"
    elb_logs_enabled = "true"

  }
  ag_instance_cluster_tag = "Simulators"
  ansible_public_key = "${var.ansible_pub_key}"
  enable_monitoring="${var.enable_monitoring}"
  disk_paths           =  [

    {
      Filesystem="/dev/xvdc"
      MountPath="/home/mettl/volume1"
    },
    {
      Filesystem="/dev/xvda1"
      MountPath="/"
    },
    {
      Filesystem = "/dev/xvdb"
      MountPath = "/home/mettl/mettl_logs"
    }



  ]

}

module "spi_elb_sg" {
  source            = "./../sg"
  sg_name           = "${format("%s", lower("r-simulator-spi-sg.${var.private_dns_zone_name}"))}"
  sg_vpc_id         = "${module.vpc.vpc_id}"
  sg_rule=[
    {
      type="ingress"
      port="10002"
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

}