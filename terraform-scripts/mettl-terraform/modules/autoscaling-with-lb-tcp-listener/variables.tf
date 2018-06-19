variable "private_dns_zone_name" {}
variable "env" {}
variable "lc_ami" { }
variable "lc_instance_type" { }
variable "lc_sg" { type="list" }
variable "as_default_cooldown" { }
variable "as_name" { }
variable "aws_region" { }
variable "user_data" { }
variable "as_max_size" { }
variable "as_min_size" { }
variable "health_check_grace_period" { }
variable "health_check_type" { }
#variable "as_desired_size" { }
variable "elb_subnet" { }
variable "elb_sg_id" { }
variable "health_check" { type="map" }
variable "as_subnet_id" { }
variable "instance_authorization_key" { }
variable "listener" {type="list"}
variable "iam_instance_profile" { }
variable "elb_idle_timeout" { default = 60}
variable "elb_connection_draining" {type="map" }
variable "elb_logs" {
  type="map"
}
variable "ag_instance_cluster_tag"{}
variable "ansible_public_key" {default = ""}
variable "notification_sns_arn" {}
variable "lc_ebs" {type="list",default=[]}
variable "enable_monitoring" {}

variable "disk_paths" {
  type="list"
  default=[
    {
      Filesystem="/dev/xvda1"
      MountPath="/boot"
    },
    {
      Filesystem="/dev/mapper/vg0-lv_mettl_logs"
      MountPath="/home/mettl/mettl_logs"
    },
    {
      Filesystem="/dev/mapper/vg0-lv_root"
      MountPath ="/"
    },
    {
      Filesystem="/dev/mapper/vg0-lv_mettl_volume1"
      MountPath="/home/mettl/volume1"
    }
  ]
}
variable "as_notification_sns_arn" {}
/*
variable "as_enabled_metrics" {
   description="auto scaling enabled metrics list
   default=[]
}


*/

