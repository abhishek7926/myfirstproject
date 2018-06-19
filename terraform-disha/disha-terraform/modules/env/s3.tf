//module "disha_document" {
//  source = "../s3"
//  bucket_name = "${var.disha_document_bucket_name}"
//  aws_region = "${var.aws_region}"
//  policy = <<POLICY
//{
//   "Version": "2012-10-17",
//   "Statement": [
//       {
//           "Sid": "AddPerm",
//           "Effect": "Allow",
//           "Principal": "*",
//           "Action": "s3:GetObject",
//           "Resource": "arn:aws:s3:::${var.disha_document_bucket_name}/*"
//       }
//   ]
//}
//POLICY
//}
//
//module "disha_email" {
//  source = "../s3"
//  bucket_name = "${var.disha_email_bucket_name}"
//  aws_region = "${var.aws_region}"
//  policy = <<POLICY
//{
//    "Version": "2012-10-17",
//    "Statement": [
//        {
//            "Sid": "AllowSESPuts-1494229053172",
//            "Effect": "Allow",
//            "Principal": {
//                "Service": "ses.amazonaws.com"
//            },
//            "Action": "s3:PutObject",
//            "Resource": "arn:aws:s3:::${var.disha_email_bucket_name}/*",
//            "Condition": {
//                "StringEquals": {
//                    "aws:Referer": "${var.aws_account_number}"
//                }
//            }
//        }
//    ]
//}
//POLICY
//}
//
//module "disha_email_notification" {
//  source = "../s3_sqs_notification"
//  bucket_id = "${module.disha_email.bucket_id}"
//  filter_prefix = ""
//  sqs_arn = "${module.sqs_eligibility.sqs_arn}"
//}
//
//
//module "student_certificates" {
//  source = "../s3"
//  bucket_name = "${var.student_certificates_bucket_name}"
//  aws_region = "${var.aws_region}"
//  policy = <<POLICY
//{
//    "Version": "2012-10-17",
//    "Statement": [
//        {
//            "Sid": "AddPerm",
//            "Effect": "Allow",
//            "Principal": "*",
//            "Action": "s3:GetObject",
//            "Resource": [
//                "arn:aws:s3:::${var.student_certificates_bucket_name}/zip/*",
//                "arn:aws:s3:::${var.student_certificates_bucket_name}/static/*"
//            ]
//        }
//    ]
//}
//POLICY
//
//}
//
//module "disha_cms" {
//  source = "../s3_with_cors"
//  bucket_name = "${var.disha_cms_bucket_name}"
//  aws_region = "${var.aws_region}"
//  policy = <<POLICY
//{
//    "Version": "2012-10-17",
//    "Statement": [
//        {
//            "Sid": "AddPerm",
//            "Effect": "Allow",
//            "Principal": "*",
//            "Action": "s3:GetObject",
//            "Resource": "arn:aws:s3:::${var.disha_cms_bucket_name}/*"
//        }
//    ]
//}
//POLICY
//}
//
//module "disha_web" {
//  source = "../s3_with_cors"
//  bucket_name = "${var.disha_web_bucket_name}"
//  aws_region = "${var.aws_region}"
//  policy = <<POLICY
//{
//    "Version": "2012-10-17",
//    "Statement": [
//        {
//            "Sid": "AddPerm",
//            "Effect": "Allow",
//            "Principal": "*",
//            "Action": "s3:GetObject",
//            "Resource": "arn:aws:s3:::${var.disha_web_bucket_name}/*"
//        }
//    ]
//}
//POLICY
//}
//
//module "certificates_sign_zip" {
//  source = "../s3"
//  bucket_name = "${var.certificates_sign_zip_bucket_name}"
//  aws_region = "${var.aws_region}"
//  policy = <<POLICY
//{
//    "Version": "2012-10-17",
//    "Statement": [
//        {
//            "Sid": "AddPerm",
//            "Effect": "Allow",
//            "Principal": "*",
//            "Action": "s3:GetObject",
//            "Resource": [
//                "arn:aws:s3:::${var.certificates_sign_zip_bucket_name}/certificate/*"
//            ]
//        }
//    ]
//}
//POLICY
//}
//
//module "cert_sign_zip_notification" {
//  source = "../s3_sqs_notification"
//  bucket_id = "${module.certificates_sign_zip.bucket_id}"
//  filter_prefix = ""
//  sqs_arn = "${module.sqs_eligibility_sign_certificate.sqs_arn}"
//}
//
//module "disha_reporting_data" {
//  source = "../s3"
//  bucket_name = "${var.reporting_data_bucket_name}"
//  aws_region = "${var.aws_region}"
//}
//
//module "disha_cms_wordpress_bucket" {
//  source = "../s3"
//  bucket_name = "${var.cms_wordpress_bucket_name}"
//  aws_region = "${var.aws_region}"
//}