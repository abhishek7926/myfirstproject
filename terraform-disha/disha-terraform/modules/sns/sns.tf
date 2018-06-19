resource "aws_sns_topic" "sns_topic" {
  name = "${var.name}"
}

#resource "aws_sns_topic_subscription" "sns_topic_subscription" {
#  count = "${ length(var.alerts_email)}"
#  topic_arn = "${aws_sns_topic.sns_topic.arn}"
#  protocol  = "email"
#  endpoint  = "${element(var.alerts_email, count.index)}"
#}


