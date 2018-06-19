
variable "additional_sg" {}
variable "instance_type" {
}

variable "instance_ami_id" {
}

variable "instance_authorization_key" {
}

variable "instance_subnet_id" {
}

variable "instance_name" {
}


variable "vpc_id" {
}

variable "instance_user" {
}
variable "alarm_notification_arn"{}


variable "instance_password" {
}
variable "instance_cluster_tag"{}



variable "sg_rule" {
  type="list"
}


variable "private_dns_zone_name" {
}

variable "private_route53_zone_id" {
}
variable "instance_ebs_optimized" {}