resource "aws_iam_instance_profile" "skillmaster-profile" {
  name  = "${format("%s", lower("skillmaster-profile.${var.private_dns_zone_name}"))}"
  roles = ["${aws_iam_role.skillmaster-data-role.name}"]
}

resource "aws_iam_role" "skillmaster-data-role" {
  name = "${format("%s", lower("skillmaster-profile.${var.private_dns_zone_name}"))}"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy" "skillmaster-data-policy" {
  name = "${format("%s", lower("skillmaster-data-policy.${var.private_dns_zone_name}"))}"
  policy = "${data.template_file.skillmaster_data_policy_as_template.rendered}"

}

data "template_file" "skillmaster_data_policy_as_template" {
  template = "${file("../skill_master_data_backup_iam_policy")}"
  vars {
    bucket_name = "${var.skill_master_data_bucket_name}"
  }
}
resource "aws_iam_role_policy_attachment" "skillmaster-data-attachment" {
  policy_arn = "${aws_iam_policy.skillmaster-data-policy.arn}"
  role = "${aws_iam_role.skillmaster-data-role.id}"
}

resource "aws_iam_role_policy_attachment" "skill-master-cloudwatch-attachment" {
  policy_arn = "${aws_iam_policy.cloudwatch-policy.arn}"
  role = "${aws_iam_role.skillmaster-data-role.id}"
}

resource "aws_iam_role_policy_attachment" "skillmaster-s3-log-policy-attachment" {
  policy_arn = "${aws_iam_policy.s3-logs-policy.arn}"
  role = "${aws_iam_role.skillmaster-data-role.id}"
}