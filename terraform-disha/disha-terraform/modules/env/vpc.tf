module "vpc" {
  source = "../vpc"

  aws_region = "${var.aws_region}"
  vpc_id = "${var.vpc_id}"
  vpc_igw_id = "${var.vpc_igw_id}"

  vpc_cidr = "${var.vpc_cidr}"
  maintenance_subnet_cidr = "${var.maintenance_subnet_cidr}"
  additional_maintenance_subnet_cidr = "${var.additional_maintenance_subnet_cidr}"
  application_subnet_cidr = "${var.application_subnet_cidr}"
  additional_application_subnet_cidr = "${var.additional_application_subnet_cidr}"
  public_subnet_cidr = "${var.public_subnet_cidr}"
  additional_public_subnet_cidr = "${var.additional_public_subnet_cidr}"

  public_key_path = "${var.public_key_path}"
  key_name = "${var.key_name}"
  default_az = "${var.default_az}"
  additional_az = "${var.additional_az}"
  private_dns_zone_name = "${var.private_dns_zone_name}"
  public_dns_zone_name = "${var.public_dns_zone_name}"
  nat_eip_allocation_id = "${lookup(var.eips,"nat")}"
  is_info_new_domain = "${var.is_info_new_domain}"
  public_dns_info_zone_name = "${var.public_dns_info_zone_name}"
}
