resource "aws_iam_instance_profile" "report-db-updator-instance-profile" {
  name  = "${var.env}-report-db-updator-instance-profile"
  roles = ["${aws_iam_role.report-db-updator-instance-role.name}"]
}

resource "aws_iam_role" "report-db-updator-instance-role" {
  name = "${var.env}-report-db-updator-instance-profile"
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

resource "aws_iam_role_policy_attachment" "deployment-policy-attachment-for-report-db-updator-instance" {
  policy_arn = "${aws_iam_policy.get-deployement-version-policy.arn}"
  role       = "${aws_iam_role.report-db-updator-instance-role.name}"
}

resource "aws_iam_role_policy_attachment" "s3-logs-attachment-for-report-db-updator-instance" {
  policy_arn = "${aws_iam_policy.s3-logs-policy.arn}"
  role       = "${aws_iam_role.report-db-updator-instance-role.id}"
}
resource "aws_iam_role_policy_attachment" "cloudwatch-attachment-for-report-db-updator-instance" {
  policy_arn = "${aws_iam_policy.cloudwatch-policy.arn}"
  role = "${aws_iam_role.report-db-updator-instance-role.id}"
}
resource "aws_iam_role_policy_attachment" "ec2-read-attachment-for-report-db-updator-instance" {
  policy_arn = "${aws_iam_policy.ec2-read-policy.arn}"
  role = "${aws_iam_role.report-db-updator-instance-role.id}"
}
