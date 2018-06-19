module "mongodb_light_instance_new" {
  source                     = "../instance-with-generic-userdata"
  instance_type              = "${var.mongodb_light_member1_instance_type}"
  instance_ami_id            = "${var.aws_mongodb_light_member1_ami}"
  instance_authorization_key = "${module.vpc.auth_id}"
  instance_subnet_id         = "${module.vpc.application_subnet_id}"
  instance_name              = "mongo-light-new"
  additional_sg		     = "${aws_security_group.application_sg.id}"
  vpc_id                     = "${module.vpc.vpc_id}"
  env                        = "${var.env}"
  enable_monitoring          = "${var.enable_monitoring}"
  sg_rule=[
{
  type="ingress"
  port="27017"
  protocol="tcp"
  cidr="${var.vpc_cidr}"
}

]
private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
private_dns_zone_name      = "${var.private_dns_zone_name}"
instance_cluster_tag = "Platform-Core-Server"
alarm_notification_arn = "${module.platform_core_server_sns.sns_arn}"
instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
ansible_pub_key = "${var.ansible_pub_key}"
disk_paths           = "${var.mongo_light_member_disk_paths}"

}

module "mongodb_light_member2_instance_new" {
source                     = "../instance-with-generic-userdata"
instance_type              = "${var.mongodb_light_member2_instance_type}"
instance_ami_id            = "${var.aws_mongodb_light_member2_ami}"
instance_authorization_key = "${module.vpc.auth_id}"
instance_subnet_id         = "${module.vpc.application_subnet_id}"
instance_name              = "mongo-light-member2-new"
additional_sg		     = "${aws_security_group.application_sg.id}"
vpc_id                     = "${module.vpc.vpc_id}"
env                        = "${var.env}"
enable_monitoring          = "${var.enable_monitoring}"
ansible_pub_key = "${var.ansible_pub_key}"
sg_rule=[
{
type="ingress"
port="27017"
protocol="tcp"
cidr="${var.vpc_cidr}"
}

]
private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
private_dns_zone_name      = "${var.private_dns_zone_name}"
instance_cluster_tag = "Platform-Core-Server"
alarm_notification_arn = "${module.platform_core_server_sns.sns_arn}"
instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
disk_paths           =   "${var.mongo_light_member_disk_paths}"

}


module "mongodb_light_member3_instance_new" {
source                     = "../instance-with-generic-userdata"
instance_type              = "${var.mongodb_light_member3_instance_type}"
instance_ami_id            = "${var.aws_mongodb_light_member3_ami}"
instance_authorization_key = "${module.vpc.auth_id}"
instance_subnet_id         = "${module.vpc.application_subnet_id}"
instance_name              = "mongo-light-member3-new"
additional_sg		     = "${aws_security_group.application_sg.id}"
vpc_id                     = "${module.vpc.vpc_id}"
env                        = "${var.env}"
enable_monitoring          = "${var.enable_monitoring}"
ansible_pub_key = "${var.ansible_pub_key}"
sg_rule=[
{
type="ingress"
port="27017"
protocol="tcp"
cidr="${var.vpc_cidr}"
}

]
private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
private_dns_zone_name      = "${var.private_dns_zone_name}"
instance_cluster_tag = "Platform-Core-Server"
alarm_notification_arn = "${module.platform_core_server_sns.sns_arn}"
instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
disk_paths           =   "${var.mongo_light_member_disk_paths}"

}


module "mongodb_primary_instance_new" {
source                     = "../instance-with-generic-userdata"
instance_type              = "${var.mongodb_heavy_member1_instance_type}"
instance_ami_id            = "${var.aws_mongodb_heavy_member1_ami}"
instance_authorization_key = "${module.vpc.auth_id}"
instance_subnet_id         = "${module.vpc.application_subnet_id}"
instance_name              = "mongo-primary-new"
additional_sg		     = "${aws_security_group.application_sg.id}"
vpc_id                     = "${module.vpc.vpc_id}"
env                        = "${var.env}"
enable_monitoring          = "${var.enable_monitoring}"
ansible_pub_key = "${var.ansible_pub_key}"
sg_rule=[
{
type="ingress"
port="27017"
protocol="tcp"
cidr="${var.vpc_cidr}"
}

]
private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
private_dns_zone_name      = "${var.private_dns_zone_name}"
instance_cluster_tag = "Platform-Core-Server"
alarm_notification_arn = "${module.platform_core_server_sns.sns_arn}"
instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
disk_paths           = "${var.mongo_heavy_member_disk_paths}"
}

module "mongodb_heavy_member2_instance_new" {
source                     = "../instance-with-generic-userdata"
instance_type              = "${var.mongodb_heavy_member2_instance_type}"
instance_ami_id            = "${var.aws_mongodb_heavy_member2_ami}"
instance_authorization_key = "${module.vpc.auth_id}"
instance_subnet_id         = "${module.vpc.application_subnet_id}"
instance_name              = "mongo-primary-member2-new"
additional_sg		     = "${aws_security_group.application_sg.id}"
vpc_id                     = "${module.vpc.vpc_id}"
env                        = "${var.env}"
enable_monitoring          = "${var.enable_monitoring}"
ansible_pub_key = "${var.ansible_pub_key}"
sg_rule=[
{
type="ingress"
port="27017"
protocol="tcp"
cidr="${var.vpc_cidr}"
}

]
private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
private_dns_zone_name      = "${var.private_dns_zone_name}"
instance_cluster_tag = "Platform-Core-Server"
alarm_notification_arn = "${module.platform_core_server_sns.sns_arn}"
instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
disk_paths           = "${var.mongo_heavy_member_disk_paths}"
}



module "mongodb_primary_arbiter_instance_new" {
source                     = "../instance-with-generic-userdata"
instance_type              = "${var.mongodb_heavy_arbiter_instance_type}"
instance_ami_id            = "${var.aws_mongodb_heavy_arbiter_ami}"
instance_authorization_key = "${module.vpc.auth_id}"
instance_subnet_id         = "${module.vpc.application_subnet_id}"
instance_name              = "mongo-primary-arbiter-new"
additional_sg		     = "${aws_security_group.application_sg.id}"
vpc_id                     = "${module.vpc.vpc_id}"
env                        = "${var.env}"
enable_monitoring          = "${var.enable_monitoring}"
ansible_pub_key = "${var.ansible_pub_key}"
sg_rule=[
{
type="ingress"
port="27017"
protocol="tcp"
cidr="${var.vpc_cidr}"
}

]
private_route53_zone_id            = "${module.vpc.private_route53_zone_id}"
private_dns_zone_name      = "${var.private_dns_zone_name}"
instance_cluster_tag = "Platform-Core-Server"
alarm_notification_arn = "${module.platform_core_server_sns.sns_arn}"
instance_iam_profile = "${aws_iam_instance_profile.instance-profile.id}"
disk_paths           =  "${var.mongo_heavy_arbiter_disk_paths}"
}