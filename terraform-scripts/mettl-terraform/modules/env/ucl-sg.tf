module "ucl_elb_sg" {
  source            = "./../sg"
  sg_name           = "${format("%s", lower("ucl_elb-sg.${var.private_dns_zone_name}"))}"
  sg_vpc_id         = "${module.vpc.vpc_id}"
  sg_rule=[
    {
      type="ingress"
      port="9411"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="egress"
      port="0"
      protocol="-1"
      cidr="0.0.0.0/0"
    }


  ]

}


module "ucl_sg" {
  source            = "./../sg"
  sg_name           = "${format("%s", lower("ucl-sg.${var.private_dns_zone_name}"))}"
  sg_vpc_id         = "${module.vpc.vpc_id}"
  sg_rule=[
    {
      type="ingress"
      port="9311"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    }
  ]

}
