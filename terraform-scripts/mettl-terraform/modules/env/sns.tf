module "maintenance_sns" {
  source = "../sns"
  name = "${format("%s", lower("maintenance-${var.private_dns_zone_name}"))}"
}

module "platform_core_server_sns" {
  source = "../sns"
  name = "${format("%s", lower("platform-core-server-${var.private_dns_zone_name}"))}"
}

module "proctoring_sns" {
  source = "../sns"
  name = "${format("%s", lower("proctoring-${var.private_dns_zone_name}"))}"
}

module "simulators_sns" {
  source = "../sns"
  name = "${format("%s", lower("simulators-${var.private_dns_zone_name}"))}"
}

module "platform_sns" {
  source = "../sns"
  name = "${format("%s", lower("platform-${var.private_dns_zone_name}"))}"
}

module "question_services_sns" {
  source = "../sns"
  name = "${format("%s", lower("question-services-${var.private_dns_zone_name}"))}"
}

module "reporting_sns" {
  source = "../sns"
  name = "${format("%s", lower("reporting-${var.private_dns_zone_name}"))}"
}

module "apps_sns" {
  source = "../sns"
  name = "${format("%s", lower("apps-${var.private_dns_zone_name}"))}"
}

module "maintenance_as_sns" {
  source = "../sns"
  name = "${format("%s", lower("maintenance-${var.private_dns_zone_name}"))}"
}

module "platform_core_server_as_sns" {
  source = "../sns"
  name = "${format("%s", lower("platform-core-server-as-${var.private_dns_zone_name}"))}"
}

module "proctoring_as_sns" {
  source = "../sns"
  name = "${format("%s", lower("proctoring-as-${var.private_dns_zone_name}"))}"
}

module "simulators_as_sns" {
  source = "../sns"
  name = "${format("%s", lower("simulators-as-${var.private_dns_zone_name}"))}"
}

module "platform_as_sns" {
  source = "../sns"
  name = "${format("%s", lower("platform-as-${var.private_dns_zone_name}"))}"
}

module "question_services_as_sns" {
  source = "../sns"
  name = "${format("%s", lower("question-services-as-${var.private_dns_zone_name}"))}"
}

module "reporting_as_sns" {
  source = "../sns"
  name = "${format("%s", lower("reporting-as-${var.private_dns_zone_name}"))}"
}

module "apps_as_sns" {
  source = "../sns"
  name = "${format("%s", lower("apps-as-${var.private_dns_zone_name}"))}"
}

