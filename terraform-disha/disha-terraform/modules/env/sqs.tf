module "sqs_certificate" {
  source = "../sqs"
  sqs_name = "certificate"
  env = "${var.env}"

}

module "sqs_certificate_status" {
  source = "../sqs"
  sqs_name = "certificate-status"
  env = "${var.env}"

}


module "sqs_lambda_execution_rate_limiter" {
  source = "../sqs"
  sqs_name = "lambda-execution-rate-limiter-queue"
  env = "${var.env}"

}

module "sqs_excel_reports" {
  source = "../sqs"
  sqs_name = "excel-reports"
  env = "${var.env}"

}

module "sqs_eligibility" {
  source = "../sqs"
  sqs_name = "ses-email"
  env = "${var.env}"
  sqs_policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "example-ID",
  "Statement": [
    {
      "Sid": "example-statement-ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "SQS:SendMessage",
      "Resource": "arn:aws:sqs:${var.aws_region}:${var.aws_account_number}:${var.env}-ses-email",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "arn:aws:s3:*:*:${var.disha_email_bucket_name}"
        }
      }
    }
  ]
}
POLICY

}

module "sqs_emailid_verification" {
  source = "../sqs"
  sqs_name = "emailid-verification"
  env = "${var.env}"

}

module "sqs_eligibility_sign_certificate" {
  source = "../sqs"
  sqs_name = "eligibility-sign-certificate"
  env = "${var.env}"
  sqs_policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "example-ID",
  "Statement": [
    {
      "Sid": "example-statement-ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "SQS:SendMessage",
      "Resource": "arn:aws:sqs:${var.aws_region}:${var.aws_account_number}:${var.env}-eligibility-sign-certificate",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "arn:aws:s3:*:*:${var.certificates_sign_zip_bucket_name}"
        }
      }
    }
  ]
}
POLICY

}

module "sqs_biometric_admin" {
  source = "../sqs"
  sqs_name = "biometric-admin"
  env = "${var.env}"

}

module "sqs_data-engine-student-dead-letter" {
  source = "../sqs"
  sqs_name = "data-engine-student-dead-letter"
  env = "${var.env}"
}

module "sqs_data-engine-student" {
  source = "../sqs"
  sqs_name = "data-engine-student"
  env = "${var.env}"
  visibility_timeout = "180"
  sqs_redrive_policy = <<EOF
{"deadLetterTargetArn":"${module.sqs_data-engine-student-dead-letter.sqs_arn}","maxReceiveCount":3}
EOF
}

module "sqs_data-engine-tc-dead-letter" {
  source = "../sqs"
  sqs_name = "data-engine-tc-dead-letter"
  env = "${var.env}"
}

module "sqs_data-engine-tc" {
  source = "../sqs"
  sqs_name = "data-engine-tc"
  env = "${var.env}"
  visibility_timeout = "180"
  sqs_redrive_policy = <<EOF
{"deadLetterTargetArn":"${module.sqs_data-engine-tc-dead-letter.sqs_arn}","maxReceiveCount":3}
EOF
}

module "sqs_data-engine-tp-dead-letter" {
  source = "../sqs"
  sqs_name = "data-engine-tp-dead-letter"
  env = "${var.env}"
}

module "sqs_data-engine-tp" {
  source = "../sqs"
  sqs_name = "data-engine-tp"
  env = "${var.env}"
  visibility_timeout = "180"
  sqs_redrive_policy = <<EOF
{"deadLetterTargetArn":"${module.sqs_data-engine-tp-dead-letter.sqs_arn}","maxReceiveCount":3}
EOF
}

module "sqs_data-processing-engine-dead-letter" {
  source = "../sqs"
  sqs_name = "data-processing-engine-dead-letter"
  env = "${var.env}"
}

module "sqs_data-processing-engine" {
  source = "../sqs"
  sqs_name = "data-processing-engine"
  env = "${var.env}"
  visibility_timeout = "180"
  sqs_redrive_policy = <<EOF
{"deadLetterTargetArn":"${module.sqs_data-processing-engine-dead-letter.sqs_arn}","maxReceiveCount":3}
EOF

}