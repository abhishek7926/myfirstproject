resource "aws_iam_instance_profile" "autoscaling-deployment-s3logs-iam-profile" {
  name  = "${format("%s", lower("autoscaling-deployment-s3logs-iam-profile.${var.private_dns_zone_name}"))}"
  roles = ["${aws_iam_role.autoscaling-deployment-s3logs-iam-role.name}"]
}

resource "aws_iam_role" "autoscaling-deployment-s3logs-iam-role" {
  name = "${format("%s", lower("autoscaling-deployment-s3logs-iam-profile.${var.private_dns_zone_name}"))}"
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

resource "aws_iam_role_policy_attachment" "deployment-autoscaling-policy-attachment" {
  role       = "${aws_iam_role.autoscaling-deployment-s3logs-iam-role.name}"
  policy_arn = "${aws_iam_policy.get-deployement-version-policy.arn}"
}
resource "aws_iam_role_policy_attachment" "cloudwatch-policy-attachment" {
  role       = "${aws_iam_role.autoscaling-deployment-s3logs-iam-role.name}"
  policy_arn = "${aws_iam_policy.cloudwatch-policy.arn}"
}

resource "aws_iam_role_policy_attachment" "s3logs-autoscaling-policy-attachment" {
  role       = "${aws_iam_role.autoscaling-deployment-s3logs-iam-role.name}"
  policy_arn = "${aws_iam_policy.s3-logs-policy.arn}"
}

resource "aws_iam_role_policy_attachment" "ec2-read-attachment-for-autoscaling" {
  policy_arn = "${aws_iam_policy.ec2-read-policy.arn}"
  role = "${aws_iam_role.autoscaling-deployment-s3logs-iam-role.id}"
}

resource "aws_iam_role_policy_attachment" "autoscaling-read-attachment" {
  policy_arn = "${aws_iam_policy.autoscaling-read-policy.arn}"
  role = "${aws_iam_role.autoscaling-deployment-s3logs-iam-role.id}"
}