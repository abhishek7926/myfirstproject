
module "autoscaling-disk-utilization" {
  source = "../monitoring/disk_utilization/disk_utilization_as"
  enable_monitoring="${var.enable_monitoring}"
  disk_paths = "${var.disk_paths}"
  monitoring_params = "${var.disk_monitoring_params}"
  alarm_notification_arn = "${var.sns_arn}"
  as_name = "${format("%s", lower("${var.as_name}-as.${var.private_dns_zone_name}"))}"
  env = "${var.env}"
}
module "autoscaling-inode-utilization" {
  source = "../monitoring/inodes/inodes_as"
  enable_monitoring="${var.enable_monitoring}"
  disk_paths = "${var.disk_paths}"
  monitoring_params = "${var.inodes_monitoring_params}"
  alarm_notification_arn = "${var.sns_arn}"
  as_name = "${format("%s", lower("${var.as_name}-as.${var.private_dns_zone_name}"))}"
  env = "${var.env}"
}
//module "autoscaling-load-average" {
//  source = "../monitoring/load_average/load_average_as"
//  enable_monitoring="${var.enable_monitoring}"
//  monitoring_params = "${var.load_average_monitoring_params}"
//  as_name = "${format("%s", lower("${var.as_name}-as.${var.private_dns_zone_name}"))}"
//  alarm_notification_arn = "${var.sns_arn}"
//  env = "${var.env}"
//}
module "autoscaling-memory" {
  source = "../monitoring/memory_utilization/memory_utilization_as"
  enable_monitoring="${var.enable_monitoring}"
  monitoring_params = "${var.memory_monitoring_params}"
  as_name = "${format("%s", lower("${var.as_name}-as.${var.private_dns_zone_name}"))}"
  alarm_notification_arn = "${var.sns_arn}"
  env = "${var.env}"
}

module "autoscaling-swap" {
  source = "../monitoring/swap_utilization/swap_utilization_as"
  enable_monitoring="${var.enable_monitoring}"
  monitoring_params = "${var.swap_monitoring_params}"
  as_name = "${format("%s", lower("${var.as_name}-as.${var.private_dns_zone_name}"))}"
  alarm_notification_arn = "${var.sns_arn}"
  env = "${var.env}"
}