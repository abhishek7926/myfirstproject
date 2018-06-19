resource "aws_ses_active_receipt_rule_set" "ses_active_rule" {
  rule_set_name = "${var.ses_rule_set_name}"
  provider      = "aws.aws_ses"
}

//resource "aws_ses_receipt_rule_set" "ses_rule_set" {
//  rule_set_name = "${var.ses_rule_set_name}"
//  provider      = "aws.aws_ses"
//}

resource "aws_ses_receipt_rule" "ses_rule" {
  name          = "${var.ses_rule_name}"
  rule_set_name = "${var.ses_rule_set_name}"
  recipients    = ["${var.recipients_email}"]
  enabled       = true
  scan_enabled  = true
//  after         = "dev-goahead-pmgdishamain-in"
  provider      = "aws.aws_ses"

  s3_action {
    position = "${var.ses_rule_position}"
    bucket_name = "${var.bucket_name}"
    object_key_prefix = "${var.bucket_prefix}"
  }
}

