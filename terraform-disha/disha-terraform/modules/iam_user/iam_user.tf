resource "aws_iam_user" "iam_user" {
  name = "${var.env}-${var.iam_user_name}"
}

resource "aws_iam_access_key" "iam_access_key" {
  user = "${aws_iam_user.iam_user.name}"
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "${aws_iam_user.iam_user.name}-policy"
  user = "${aws_iam_user.iam_user.name}"
  policy = "${var.iam_policy}"
}
