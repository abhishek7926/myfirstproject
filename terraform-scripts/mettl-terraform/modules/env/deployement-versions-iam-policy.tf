resource "aws_iam_policy" "get-deployement-version-policy" {
  name = "${format("%s", lower("get-deployement-version.${var.private_dns_zone_name}"))}"
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

                "arn:aws:s3:::deployement-versions"
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

                "arn:aws:s3:::deployement-versions/*"
            ]
        }
    ]
}
EOF
}
