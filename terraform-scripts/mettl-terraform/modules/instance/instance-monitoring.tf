
module "instance-disk-utilization" {
  source = "../monitoring/disk_utilization/disk_utilization_instance"
  enable_monitoring="${var.enable_monitoring}"
  disk_paths = "${var.disk_paths}"
  monitoring_params = "${var.disk_monitoring_params}"
  alarm_notification_arn = "${var.alarm_notification_arn}"
  instance_id = "${aws_instance.instance.id}"
  instance_name = "${aws_instance.instance.tags.Name}"
  env = "${var.env}"
}
module "instance-inode-utilization" {
  source = "../monitoring/inodes/inodes_instance"
  enable_monitoring="${var.enable_monitoring}"
  disk_paths = "${var.disk_paths}"
  monitoring_params = "${var.inodes_monitoring_params}"
  alarm_notification_arn = "${var.alarm_notification_arn}"
  instance_id = "${aws_instance.instance.id}"
  instance_name = "${aws_instance.instance.tags.Name}"
  env = "${var.env}"
}
//module "instance-load-average" {
//  source = "../monitoring/load_average/load_average_instance"
//  enable_monitoring="${var.enable_monitoring}"
//  monitoring_params = "${var.load_average_monitoring_params}"
//  instance_id = "${aws_instance.instance.id}"
//  instance_name = "${aws_instance.instance.tags.Name}"
//  alarm_notification_arn = "${var.alarm_notification_arn}"
//  env = "${var.env}"
//}
module "instance-memory" {
  source = "../monitoring/memory_utilization/memory_utilization_instance"
  enable_monitoring="${var.enable_monitoring}"
  monitoring_params = "${var.memory_monitoring_params}"
  instance_id = "${aws_instance.instance.id}"
  instance_name = "${aws_instance.instance.tags.Name}"
  alarm_notification_arn = "${var.alarm_notification_arn}"
  env = "${var.env}"
}

module "instance-swap" {
  source = "../monitoring/swap_utilization/swap_utilization_instance"
  enable_monitoring="${var.enable_monitoring}"
  monitoring_params = "${var.swap_monitoring_params}"
  instance_id = "${aws_instance.instance.id}"
  instance_name = "${aws_instance.instance.tags.Name}"
  alarm_notification_arn = "${var.alarm_notification_arn}"
  env = "${var.env}"
}