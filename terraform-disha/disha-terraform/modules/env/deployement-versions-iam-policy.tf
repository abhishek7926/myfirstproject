resource "aws_iam_policy" "get-deployement-version-policy" {
  name = "${var.env}-get-deployement-version"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [

                "arn:aws:s3:::${var.env}-deployement-versions"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": [

                "arn:aws:s3:::${var.env}-deployement-versions/*"
            ]
        }
    ]
}
EOF
}
