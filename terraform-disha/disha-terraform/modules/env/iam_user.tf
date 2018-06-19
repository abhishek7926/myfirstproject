module "iam_user_disha_web" {
  source = "../iam_user"
  env = "${var.env}"
  iam_user_name = "web-iam-user"
  iam_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1489128738000",
            "Effect": "Allow",
            "Action": [
                "sqs:AddPermission",
                "sqs:ChangeMessageVisibility",
                "sqs:ChangeMessageVisibilityBatch",
                "sqs:CreateQueue",
                "sqs:GetQueueAttributes",
                "sqs:GetQueueUrl",
                "sqs:ListDeadLetterSourceQueues",
                "sqs:ListQueues",
                "sqs:PurgeQueue",
                "sqs:ReceiveMessage",
                "sqs:SendMessage",
                "sqs:SendMessageBatch",
                "sqs:SetQueueAttributes",
                "sqs:DeleteMessage"
            ],
            "Resource": [
                "${module.sqs_excel_reports.sqs_arn}",
                "${module.sqs_data-engine-student.sqs_arn}",
                "${module.sqs_data-engine-tc.sqs_arn}",
                "${module.sqs_data-engine-tp.sqs_arn}",
                "${module.sqs_data-processing-engine.sqs_arn}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::${var.disha_document_bucket_name}/*"
            ]
        }
    ]
}
POLICY
}

module "iam_user_disha_eligibilitty" {
  source = "../iam_user"
    env = "${var.env}"
  iam_user_name = "eligibility-iam-user"
  iam_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1489128738000",
            "Effect": "Allow",
            "Action": [
                "sqs:AddPermission",
                "sqs:ChangeMessageVisibility",
                "sqs:ChangeMessageVisibilityBatch",
                "sqs:CreateQueue",
                "sqs:GetQueueAttributes",
                "sqs:GetQueueUrl",
                "sqs:ListDeadLetterSourceQueues",
                "sqs:ListQueues",
                "sqs:PurgeQueue",
                "sqs:ReceiveMessage",
                "sqs:SendMessage",
                "sqs:SendMessageBatch",
                "sqs:SetQueueAttributes",
                "sqs:DeleteMessage"
            ],
            "Resource": [
                "${module.sqs_excel_reports.sqs_arn}",
                "${module.sqs_eligibility.sqs_arn}",
                "${module.sqs_eligibility_sign_certificate.sqs_arn}",
                "${module.sqs_emailid_verification.sqs_arn}",
                "${module.sqs_biometric_admin.sqs_arn}",
                "${module.sqs_data-engine-student.sqs_arn}",
                "${module.sqs_data-engine-tc.sqs_arn}",
                "${module.sqs_data-engine-tp.sqs_arn}",
                "${module.sqs_data-processing-engine.sqs_arn}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::${var.disha_document_bucket_name}/*",
                "arn:aws:s3:::${var.disha_email_bucket_name}/*",
                "arn:aws:s3:::${var.certificates_sign_zip_bucket_name}/*",
                "arn:aws:s3:::${var.student_certificates_bucket_name}/*"
            ]
        }
    ]
}
POLICY
}

module "iam_user_disha_certificate" {
  source = "../iam_user"
    env = "${var.env}"
  iam_user_name = "certificate-iam-user"
  iam_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1489128738000",
            "Effect": "Allow",
            "Action": [
                "sqs:AddPermission",
                "sqs:ChangeMessageVisibility",
                "sqs:ChangeMessageVisibilityBatch",
                "sqs:CreateQueue",
                "sqs:GetQueueAttributes",
                "sqs:GetQueueUrl",
                "sqs:ListDeadLetterSourceQueues",
                "sqs:ListQueues",
                "sqs:PurgeQueue",
                "sqs:ReceiveMessage",
                "sqs:SendMessage",
                "sqs:SendMessageBatch",
                "sqs:SetQueueAttributes",
                "sqs:DeleteMessage"
            ],
            "Resource": [
                "${module.sqs_certificate.sqs_arn}",
                "${module.sqs_certificate_status.sqs_arn}",
                "${module.sqs_lambda_execution_rate_limiter.sqs_arn}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::${var.student_certificates_bucket_name}/*",
                "arn:aws:s3:::${var.disha_document_bucket_name}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "sns:Publish"
            ],
            "Resource": [
                "${module.certificate_sns.sns_arn}"
            ]
        }
    ]
}
POLICY
}

module "iam_user_hkcl_certificate" {
  source = "../iam_user"
  env = "${var.env}"
  iam_user_name = "hkcl-certificate"
  iam_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1480692207000",
            "Effect": "Deny",
            "Action": [
                "s3:DeleteObject",
                "s3:DeleteObjectVersion"
            ],
            "Resource": [
                "arn:aws:s3:::${var.certificates_sign_zip_bucket_name}/hkcl/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::${var.certificates_sign_zip_bucket_name}/hkcl/*"
            ]
        }
    ]
}
POLICY
}

module "iam_user_nios_certificate" {
  source = "../iam_user"
  env = "${var.env}"
  iam_user_name = "nios-certificate"
  iam_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1480692207000",
            "Effect": "Deny",
            "Action": [
                "s3:DeleteObject",
                "s3:DeleteObjectVersion"
            ],
            "Resource": [
                "arn:aws:s3:::${var.certificates_sign_zip_bucket_name}/nios/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::${var.certificates_sign_zip_bucket_name}/nios/*"
            ]
        }
    ]
}
POLICY
}

module "iam_disha_reporting_user" {
  source = "../iam_user"
  env = "${var.env}"
  iam_user_name = "reporting"
  iam_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowUserToSeeBucketListInTheConsole",
            "Action": [
                "s3:ListAllMyBuckets",
                "s3:GetBucketLocation"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::*"
            ]
        },
        {
            "Sid": "Stmt1470315667000",
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::${var.reporting_data_bucket_name}",
                "arn:aws:s3:::${var.reporting_data_bucket_name}/*"
            ]
        },
        {
            "Sid": "AllowUserToTopicListInTheConsole",
            "Action": [
                "sns:ListTopics",
                "sns:ListSubscriptions"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:sns:::*"
            ]
        },
        {
            "Sid": "Stmt1489128738000",
            "Effect": "Allow",
            "Action": [
                "sns:*"
            ],
            "Resource": [
                "arn:aws:sns:${var.aws_region}:${var.aws_account_number}:${var.env}-stop-report-ec2-instance"
            ]
        }
    ]
}
POLICY
}

module "iam_user_biometric_admin" {
  source = "../iam_user"
  env = "${var.env}"
  iam_user_name = "biometric-admin-user"
  iam_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1489128738000",
            "Effect": "Allow",
            "Action": [
                "sqs:AddPermission",
                "sqs:ChangeMessageVisibility",
                "sqs:ChangeMessageVisibilityBatch",
                "sqs:CreateQueue",
                "sqs:GetQueueAttributes",
                "sqs:GetQueueUrl",
                "sqs:ListDeadLetterSourceQueues",
                "sqs:ListQueues",
                "sqs:PurgeQueue",
                "sqs:ReceiveMessage",
                "sqs:SendMessage",
                "sqs:SendMessageBatch",
                "sqs:SetQueueAttributes",
                "sqs:DeleteMessage"
            ],
            "Resource": [
                "${module.sqs_biometric_admin.sqs_arn}"
            ]
        }
    ]
}
POLICY
}

module "iam_user_cms_wordpress" {
  source = "../iam_user"
  env = "${var.env}"
  iam_user_name = "cms-wordpress-user"
  iam_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "cloudfront:ListInvalidations",
                "cloudfront:GetInvalidation",
                "cloudfront:CreateInvalidation",
                "cloudfront:ListDistributions"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Stmt1513846393001",
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1513846393000",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObjectAcl",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.cms_wordpress_bucket_name}",
                "arn:aws:s3:::${var.cms_wordpress_bucket_name}/*"
            ]
        }
    ]
}
POLICY
}

module "iam_user_data-processing-engine" {
  source = "../iam_user"
  env = "${var.env}"
  iam_user_name = "data-processing-engine"
  iam_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1489128738000",
            "Effect": "Allow",
            "Action": [
                "sqs:AddPermission",
                "sqs:ChangeMessageVisibility",
                "sqs:ChangeMessageVisibilityBatch",
                "sqs:CreateQueue",
                "sqs:GetQueueAttributes",
                "sqs:GetQueueUrl",
                "sqs:ListDeadLetterSourceQueues",
                "sqs:ListQueues",
                "sqs:PurgeQueue",
                "sqs:ReceiveMessage",
                "sqs:SendMessage",
                "sqs:SendMessageBatch",
                "sqs:SetQueueAttributes",
                "sqs:DeleteMessage"
            ],
            "Resource": [
                "${module.sqs_data-engine-student.sqs_arn}",
                "${module.sqs_data-engine-tc.sqs_arn}",
                "${module.sqs_data-engine-tp.sqs_arn}",
                "${module.sqs_data-processing-engine.sqs_arn}"
            ]
        }
    ]
}
POLICY
}