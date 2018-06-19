module "vpc" {
  source = "../vpc"

  vpc_name = "${var.vpc_name}"
  aws_region = "${var.aws_region}"
  
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
  ucl_subnet_cidr = "${var.ucl_subnet_cidr}"
}
