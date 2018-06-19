module "elb-http-sg" {
  source            = "./../sg"
  sg_name           = "${var.env}-elb-http-sg"
  sg_vpc_id         = "${module.vpc.vpc_id}"
  sg_rule=[
    {
      type="ingress"
      port="80"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="ingress"
      port="443"
      protocol="tcp"
      cidr="0.0.0.0/0"
    },
    {
      type="egress"
      port="0"
      protocol="-1"
      cidr="0.0.0.0/0"
    }
  ]

}
