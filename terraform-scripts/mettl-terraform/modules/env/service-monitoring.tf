module "service-monitoring" {
  source = "../monitoring/service-monitoring"
  enable_monitoring = "${var.enable_monitoring}"
  env = "${var.env}"
  private_dns_zone_name="${var.private_dns_zone_name}"

autoscaling_services_to_monitor = [

  { name="livefeed-server-as",
    sns="${module.proctoring_sns.sns_arn}"
  },
  { name="proctoring-ui-as",
    sns="${module.proctoring_sns.sns_arn}"
  },
  { name="question-service-as",
    sns="${module.question_services_sns.sns_arn}"
  },
  { name="janus-livefeed-server-as",
    sns="${module.proctoring_sns.sns_arn}"
  },
  { name="yolo-as",
    sns="${module.proctoring_sns.sns_arn}"
  }

]
}