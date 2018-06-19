
variable "env" {}
variable "additional_sg" {}
variable "instance_type" {
}
variable "instance_iam_profile" {}
variable "instance_ami_id" {
}

variable "instance_authorization_key" {
}

variable "instance_subnet_id" {
}

variable "instance_name" {
}
variable "instance_cluster_tag"{}

variable "alarm_notification_arn"{}
variable "vpc_id" {
}

variable "sg_rule" {
  type="list"
}


variable "private_route53_zone_id" {
}

variable "enable_monitoring" {}
variable "instance_ebs_optimized" {default = "false"}


variable "disk_monitoring_params" {
  type = "map",
  default ={
    threshold = 80
    period = 60
    evaluation_period = 1
  }
}

variable "inodes_monitoring_params" {
  type = "map",
  default ={
    threshold = 80
    period = 60
    evaluation_period = 1
  }
}

variable "load_average_monitoring_params" {
  type = "map",
  default ={
    threshold = 0.8
    period = 60
    evaluation_period = 1
  }
}

variable "memory_monitoring_params" {
  type = "map",
  default ={
    threshold = 80
    period = 60
    evaluation_period = 1
  }
}

variable "swap_monitoring_params" {
  type = "map",
  default ={
    threshold = 80
    period = 60
    evaluation_period = 1
  }
}

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

