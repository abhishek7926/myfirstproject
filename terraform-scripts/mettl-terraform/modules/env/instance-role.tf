resource "aws_iam_instance_profile" "instance-profile" {
  name  = "${format("%s", lower("instance-profile.${var.private_dns_zone_name}"))}"
  roles = ["${aws_iam_role.instance-role.name}"]
}

resource "aws_iam_role" "instance-role" {
  name = "${format("%s", lower("instance-profile.${var.private_dns_zone_name}"))}"
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

resource "aws_iam_policy" "s3-logs-policy" {
  name = "${format("%s", lower("s3-logs-policy.${var.private_dns_zone_name}"))}"
  policy = "${data.template_file.s3_logs_policy_as_template.rendered}"

}
resource "aws_iam_policy" "cloudwatch-policy" {
  name = "${format("%s", lower("cloudwatch-policy.${var.private_dns_zone_name}"))}"
  policy = "${data.template_file.cloudwatch_policy_as_template.rendered}"

}
resource "aws_iam_policy" "ec2-read-policy" {
  name = "${format("%s", lower("ec2-read.${var.private_dns_zone_name}"))}"
  policy = "${data.template_file.ec2_read_policy_as_template.rendered}"

}
data "template_file" "ec2_read_policy_as_template" {
  template = "${file("../ec2_read_iam_policy")}"
}

data "template_file" "cloudwatch_policy_as_template" {
  template = "${file("../put_cloudwatch_iam_policy")}"
}

data "template_file" "s3_logs_policy_as_template" {
template = "${file("../s3_logs_iam_policy")}"
vars {
bucket_name = "${var.logs_bucket_name}"
}
}
resource "aws_iam_role_policy_attachment" "s3-logs-attachment" {
  policy_arn = "${aws_iam_policy.s3-logs-policy.arn}"
  role = "${aws_iam_role.instance-role.id}"
}
resource "aws_iam_role_policy_attachment" "cloudwatch-attachment" {
  policy_arn = "${aws_iam_policy.cloudwatch-policy.arn}"
  role = "${aws_iam_role.instance-role.id}"
}
resource "aws_iam_role_policy_attachment" "ec2-read-attachment" {
  policy_arn = "${aws_iam_policy.ec2-read-policy.arn}"
  role = "${aws_iam_role.instance-role.id}"
}
