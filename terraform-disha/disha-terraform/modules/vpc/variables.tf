variable "vpc_id" {}
variable "default_az" {}
//variable "vpc_name" {}
variable "vpc_igw_id" {}
variable "application_subnet_cidr" {
}
variable "maintenance_subnet_cidr" {}
variable "public_subnet_cidr" {
}
variable "additional_public_subnet_cidr" { }

variable "aws_region" {
}
variable "public_dns_zone_name" {
}
variable "vpc_cidr" {
}
variable "additional_maintenance_subnet_cidr" {}
variable "additional_application_subnet_cidr" {}


variable "additional_az" {
}
variable "key_name" {
}
variable "instance_cluster_tag"{default="Maintenance"}

variable "public_key_path" {
}

variable "private_dns_zone_name" {
}

variable "nat_eip_allocation_id" {}
variable "is_info_new_domain" {}
variable "public_dns_info_zone_name" {}