module "ses_rule" {
  source = "../ses-rule"
  ses_rule_name = "${var.ses_rule_name}"
  ses_rule_set_name = "default-rule-set"
  recipients_email = "${var.ses_recipients_email}"
  bucket_name = "${var.disha_email_bucket_name}"
  bucket_prefix = "goahead/"
  ses_rule_position = "1"
//  aws_provider = "aws.aws_ses"
}

module "ses_rule_verifycenter" {
  source = "../ses-rule"
  ses_rule_name = "${var.verifycenter_ses_rule_name}"
  ses_rule_set_name = "default-rule-set"
  recipients_email = "${var.verifycenter_ses_recipients_email}"
  bucket_name = "${var.disha_email_bucket_name}"
  bucket_prefix = "verifycenter/"
  ses_rule_position = "2"
  //  aws_provider = "aws.aws_ses"
}