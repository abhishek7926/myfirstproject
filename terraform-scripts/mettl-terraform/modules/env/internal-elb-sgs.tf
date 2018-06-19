module "internal-elb-http-sg" {
  source            = "./../sg"
  sg_name           = "${format("%s", lower("internal-elb-http-sg.${var.private_dns_zone_name}"))}"
  sg_vpc_id         = "${module.vpc.vpc_id}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="${var.vpc_cidr}"
    },
    {
      type="ingress"
      port="443"
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


