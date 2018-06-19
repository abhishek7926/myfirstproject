resource "aws_iam_instance_profile" "metrics-profile" {
  name  = "${format("%s", lower("metrics-profile.${var.private_dns_zone_name}"))}"
  roles = ["${aws_iam_role.metrics-role.name}"]
}

resource "aws_iam_role" "metrics-role" {
  name = "${format("%s", lower("metrics-profile.${var.private_dns_zone_name}"))}"
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


resource "aws_iam_role_policy_attachment" "metrics-s3-logs-attachment" {
  policy_arn = "${aws_iam_policy.s3-logs-policy.arn}"
  role = "${aws_iam_role.metrics-role.id}"
}
resource "aws_iam_role_policy_attachment" "metrics-cloudwatch-attachment" {
  policy_arn = "${aws_iam_policy.cloudwatch-policy.arn}"
  role = "${aws_iam_role.metrics-role.id}"
}
resource "aws_iam_role_policy_attachment" "metrics-ec2-read-attachment" {
  policy_arn = "${aws_iam_policy.ec2-read-policy.arn}"
  role = "${aws_iam_role.metrics-role.id}"
}


resource "aws_iam_policy" "autoscaling-read-policy" {
  name = "${format("%s", lower("autoscaling-read.${var.private_dns_zone_name}"))}"
  policy = "${data.template_file.autoscaling_read_policy_as_template.rendered}"

}
data "template_file" "autoscaling_read_policy_as_template" {
  template = "${file("../autoscaling_read_iam_policy")}"
}

resource "aws_iam_role_policy_attachment" "metrics-autoscaling-read-attachment" {
  policy_arn = "${aws_iam_policy.autoscaling-read-policy.arn}"
  role = "${aws_iam_role.metrics-role.id}"
}
