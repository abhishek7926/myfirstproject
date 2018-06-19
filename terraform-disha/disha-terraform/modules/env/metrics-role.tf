resource "aws_iam_instance_profile" "metrics-profile" {
  name  = "${var.env}-metrics-profile"
  roles = ["${aws_iam_role.metrics-role.name}"]
}

resource "aws_iam_role" "metrics-role" {
  name = "${var.env}-metrics-profile"
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
  name = "${var.env}-autoscaling-read"
  policy = "${data.template_file.autoscaling_read_policy_as_template.rendered}"

}
data "template_file" "autoscaling_read_policy_as_template" {
  template = "${file("../documents/iam-policy/autoscaling_read_iam_policy")}"
}

resource "aws_iam_role_policy_attachment" "metrics-autoscaling-read-attachment" {
  policy_arn = "${aws_iam_policy.autoscaling-read-policy.arn}"
  role = "${aws_iam_role.metrics-role.id}"
}
