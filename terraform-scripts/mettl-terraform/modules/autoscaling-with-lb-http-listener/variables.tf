

variable "lc_ami" {
}

variable "lc_instance_type" {
}

variable "lc_sg" {
type="list"
}

variable "as_default_cooldown" {
}
variable "iam_instance_profile" {
}
variable "as_name" {
}
variable "is_internal" {
  default="false"

}
variable "elb_idle_timeout" { default = 60}

variable "ag_instance_cluster_tag" {
}
variable "listener" {type="list"
  default =
[
{
listener_instance_port="80"
listener_instance_protocol="HTTP"
listener_lb_port="80"
listener_lb_protocol="HTTP"
},
{
listener_instance_port="443"
listener_instance_protocol="HTTPS"
listener_lb_port="443"
listener_lb_protocol="HTTPS"
},
]
}

variable "as_notification_sns_arn" {}



variable "aws_region" {
}

variable "user_data" {
}

variable "as_max_size" {
}

variable "env" {}
variable "private_dns_zone_name" {}

variable "as_min_size" {
}

variable "health_check_grace_period" {
}

variable "health_check_type" {
}

#variable "as_desired_size" {}




variable "elb_subnet" {
}

variable "elb_sg_id" {
}

variable "elb_connection_draining" {type="map" }

variable "ssl_certificate_id" {
}

variable "health_check"
{
type="map"
}


variable "as_subnet_id" {
}

variable "instance_authorization_key" {
}

variable "elb_logs" {
  type="map"
}
variable "notification_sns_arn" {}

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
/*
variable "as_enabled_metrics" {
   description="auto scaling enabled metrics list
   default=[]
}



*/

