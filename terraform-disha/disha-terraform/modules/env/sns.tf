module "disha_sns" {
  source = "../sns"
  name = "${var.env}-sns"
}

module "certificate_sns" {
  source = "../sns"
  name = "${var.env}-certificate-sns"
}

module "stop_report_instance_sns" {
  source = "../sns"
  name = "${var.env}-stop-report-ec2-instance"
}