resource "aws_iam_instance_profile" "instance-profile" {
  name  = "${var.env}-instance-profile"
  role = "${aws_iam_role.instance-role.name}"
}

resource "aws_iam_role" "instance-role" {
  name = "${var.env}-instance-profile"
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
  name = "${var.env}-s3-logs-policy"
  policy = "${data.template_file.s3_logs_policy_as_template.rendered}"

}
resource "aws_iam_policy" "cloudwatch-policy" {
  name = "${var.env}-cloudwatch-policy"
  policy = "${data.template_file.cloudwatch_policy_as_template.rendered}"

}
resource "aws_iam_policy" "ec2-read-policy" {
  name = "${var.env}-ec2-read"
  policy = "${data.template_file.ec2_read_policy_as_template.rendered}"

}
data "template_file" "ec2_read_policy_as_template" {
  template = "${file("../documents/iam-policy/ec2_read_iam_policy")}"
}

data "template_file" "cloudwatch_policy_as_template" {
  template = "${file("../documents/iam-policy/put_cloudwatch_iam_policy")}"
}

data "template_file" "s3_logs_policy_as_template" {
  template = "${file("../documents/iam-policy/s3_logs_iam_policy")}"
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
