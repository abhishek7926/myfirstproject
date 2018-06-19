module "web-monitoring" {
  source = "../monitoring/web-monitoring"
  enable_monitoring = "${var.enable_monitoring}"
  env = "${var.env}"
  public_dns_zone_name = "${var.public_dns_zone_name}"
  web_urls =
  [
    { pre_dns="https://", post_dns="", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="https://tests.", post_dns="/ping", response_code="200", sns="${module.platform_sns.sns_arn}" },
    { pre_dns="https://", post_dns="/corporate/login", response_code="200", sns="${module.platform_sns.sns_arn}" },
    { pre_dns="https://pr.", post_dns="/ping", response_code="200", sns="${module.platform_sns.sns_arn}" },
    { pre_dns="https://pr.", post_dns="/health", response_code="200", sns="${module.platform_sns.sns_arn}" },
    { pre_dns="https://admin.", post_dns="/login", response_code="200", sns="${module.platform_sns.sns_arn}" },
    { pre_dns="https://", post_dns="/notification", response_code="401", sns="${module.platform_sns.sns_arn}" },
    { pre_dns="https://", post_dns="/resources/images/mettl-logo.png", response_code="200", sns="${module.platform_sns.sns_arn}" },
    { pre_dns="https://mobileapp.", post_dns="/ping", response_code="200", sns="${module.platform_sns.sns_arn}" },
    { pre_dns="https://chat.", post_dns="/ping", response_code="200", sns="${module.proctoring_sns.sns_arn}" },
    { pre_dns="https://chat.", post_dns="/web-socket/ping", response_code="200", sns="${module.proctoring_sns.sns_arn}" },
    { pre_dns="https://tests.", post_dns="/coding-simulators/version", response_code="200", sns="${module.simulators_sns.sns_arn}" },
    { pre_dns="https://codingsimulators.", post_dns="/version", response_code="200", sns="${module.simulators_sns.sns_arn}" },
    { pre_dns="http://codingsimulators.", post_dns="/version", response_code="200", sns="${module.simulators_sns.sns_arn}" },
    { pre_dns="https://intellisense.", post_dns="", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="http://api-demo.", post_dns="", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="https://360feedback.", post_dns="/login", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="https://certification.", post_dns="/systemAdmin/login", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="https://", post_dns="/contests/admin/login", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="https://zydusapi.", post_dns="/v1", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="https://wiproapi.", post_dns="/v1", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="https://lms.", post_dns="/ping", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="https://proctoringstation.", post_dns="/login", response_code="200", sns="${module.proctoring_sns.sns_arn}" },
    { pre_dns="http://hpecoc.", post_dns="/candidate/register", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="https://register.", post_dns="", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="https://accenture.", post_dns="", response_code="302", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="http://igt-app.", post_dns="/status", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="https://feedback.", post_dns="/admin/login", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="https://test-notification-app.", post_dns="", response_code="200", sns="${module.platform_sns.sns_arn}" },
    { pre_dns="https://api.", post_dns="/v1", response_code="200", sns="${module.platform_sns.sns_arn}" },
    { pre_dns="https://", post_dns="/interview/admin/api/ping", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="https://", post_dns="/interview/api/ping", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="https://interview.", post_dns="/admin/api/ping", response_code="200", sns="${module.apps_sns.sns_arn}" },
    { pre_dns="https://interview.", post_dns="/api/ping", response_code="200", sns="${module.apps_sns.sns_arn}" }




  ]

}
