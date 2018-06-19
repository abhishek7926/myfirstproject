resource "aws_security_group_rule" "sg_rule" {
  count             = "${ length(var.sg_rule)}"
  type              = "${lookup(var.sg_rule[count.index],"type")}"
  from_port         = "${lookup(var.sg_rule[count.index],"port")}"
  to_port           = "${lookup(var.sg_rule[count.index],"port")}"
  protocol          = "${lookup(var.sg_rule[count.index],"protocol")}"
  cidr_blocks       = ["${lookup(var.sg_rule[count.index],"cidr")}"]
  security_group_id = "${aws_security_group.sg.id}"
}
