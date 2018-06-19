module "live_feed_service" {
  source                    = "../autoscaling"
  aws_region		    = "${var.aws_region}"
  instance_authorization_key="${module.vpc.auth_id}"
  ansible_public_key = "${var.ansible_pub_key}"
  jenkins_public_key = "${var.jenkins_pub_key}"
  as_name                   = "livefeed-server"
  sns_arn  ="${module.proctoring_sns.sns_arn}"
  as_sns_arn = "${module.proctoring_as_sns.sns_arn}"

  private_dns_zone_name="${var.private_dns_zone_name}"
  env="${var.env}"
  lc_ami                        = "${lookup(var.live_feed_service,"lc_ami")}"
  lc_instance_type              = "${lookup(var.live_feed_service,"lc_instance_type")}"
  user_data                     = "../documents/userdata/autoscaling/livefeed-service-userdata"
  as_max_size                   = "${lookup(var.live_feed_service,"as_max_size")}"
  as_min_size                   = "${lookup(var.live_feed_service,"as_min_size")}"
 # as_desired_size               = "${lookup(var.live_feed_service,"as_desired_size")}"
  as_default_cooldown           = "${lookup(var.live_feed_service,"as_default_cooldown")}"
  health_check_grace_period     = "${lookup(var.live_feed_service,"health_check_grace_period")}"
  health_check_type             = "${lookup(var.live_feed_service,"health_check_type")}"
  associate_public_ip_address   = true
  iam_instance_profile = "${aws_iam_instance_profile.autoscaling-deployment-s3logs-iam-profile.id}"

  disk_paths                = "${var.livefeed_disk_paths}"
  lc_sg                     = ["${aws_security_group.application_sg.id}","${aws_security_group.livefeed-service-sg.id}","${aws_security_group.livefeed-hazelcast.id}"]
  as_subnet_id		    = "${module.vpc.public_subnet_id}"
  ag_instance_cluster_tag = "Proctoring"
  #  as_enabled_metrics=["GroupMinSize"]

  #  depends_on = ["module.uc_elb"]
  stunServerAddress= "${var.livefeed_stun_server_address}"
  stunServerPort="${var.livefeed_stunserver_port}"
  turnURL="${var.livefeed_turn_url}"
  turnURLPort="${var.livefeed_turnURLPort}"

  enable_monitoring="${var.enable_monitoring}"
  lc_ebs = [{device_name = "/dev/xvdf",
  volume_type = "${lookup(var.lc_ebs_livefeed, "volume_type")}"
  volume_size = "${lookup(var.lc_ebs_livefeed, "volume_size")}"
  stunServerAddress="${var.livefeed_stun_server_address}"
  stunServerPort="${var.livefeed_stunserver_port}"
  turnURL="${var.livefeed_turn_url}"
  turnURLPort="${var.livefeed_turnURLPort}"
}]
}


#######CREATE SG##########


      resource "aws_security_group" "livefeed-service-sg" {
        name = "${format("%s", lower("livefeed-services-sg.${var.private_dns_zone_name}"))}"
        description = "livefeed-service"
        vpc_id = "${module.vpc.vpc_id}"
        ingress {
          from_port =8888
          to_port =8888
          protocol = "tcp"
          cidr_blocks = ["${var.vpc_cidr}"]        }

        ingress{
          from_port   = 0
          to_port     = 65535
          protocol    = "udp"
          cidr_blocks = ["0.0.0.0/0"]
        }

        tags {
          Name = "${format("%s", lower("livefeed-services-sg.${var.private_dns_zone_name}"))}"


        }

      }
