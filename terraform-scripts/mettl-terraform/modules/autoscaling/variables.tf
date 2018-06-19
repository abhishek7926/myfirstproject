variable "env" {}
variable "lc_ebs" {type="list",default=[]}
variable "private_dns_zone_name" {}
variable "lc_ami" {}
variable "lc_instance_type" {}
variable "iam_instance_profile" {}
variable "lc_sg" { type="list" }
variable "as_default_cooldown" {}
variable "ag_instance_cluster_tag" {}
variable "as_name" {}
variable "ansible_public_key" {default=""}
variable "as_elb_name" {type="list",default = []}
variable "aws_region" { }
variable "user_data" { }
variable "as_max_size" { }
variable "as_min_size" {}
variable "health_check_grace_period" { }
variable "health_check_type" { }
variable "instance_authorization_key" { }
variable "as_subnet_id" { }
variable "stunServerAddress" {default=""}
variable "stunServerPort" {default=""}
variable "turnURL" {default=""}
variable "turnURLPort" {default=""}
variable "sns_arn" {}
variable "associate_public_ip_address" { default = false }

variable "jenkins_public_key" {default=""}
variable "enable_monitoring" {}


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
variable "as_sns_arn" {}
