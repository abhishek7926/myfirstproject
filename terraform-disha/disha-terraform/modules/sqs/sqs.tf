resource "aws_sqs_queue" "sqs" {
  name = "${var.env}-${var.sqs_name}"
  delay_seconds = "${var.delay_time}"
  max_message_size = "${var.max_message_size}"
  visibility_timeout_seconds = "${var.visibility_timeout}"
  message_retention_seconds = "${var.message_retention}"
  receive_wait_time_seconds = "${var.receive_wait_time}"
  policy = "${var.sqs_policy}"
  redrive_policy = "${var.sqs_redrive_policy}"
}