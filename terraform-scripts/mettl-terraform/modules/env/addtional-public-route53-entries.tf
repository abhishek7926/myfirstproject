resource "aws_route53_record" "addtional-public-route53-entries" {
  count="${length(var.additional_route53_entries)}"
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "${lookup(var.additional_route53_entries[count.index],"name")}"
  type       = "${lookup(var.additional_route53_entries[count.index],"type")}"
  ttl        = "${lookup(var.additional_route53_entries[count.index],"ttl")}"
  records    = ["${lookup(var.additional_route53_entries[count.index],"value")}"]
}


resource "aws_route53_record" "root-mx-entries" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = ""
  type       = "MX"
  ttl        = "604800"
  records    = "${var.root_mx_record_list}"
}

resource "aws_route53_record" "root-txt-entries" {
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = ""
  type       = "TXT"
  ttl        = "3600"
  records    = "${var.root_txt_record_list}"
}

resource "aws_route53_record" "other-txt-entries" {
  count="${length(var.txt_record_map)}"
  zone_id    = "${module.vpc.public_route53_zone_id}"
  name       = "${lookup(var.txt_record_map[count.index],"name")}"
  type       = "TXT"
  ttl        = "3600"
  records    = ["${lookup(var.txt_record_map[count.index],"value")}"]

}