//resource "aws_s3_bucket" "bucket" {
//  bucket = "${var.bucket_name}"
//  acl = "private"
//  region = "${var.aws_region}"
//  policy = "${var.policy}"
//  cors_rule {
//    allowed_headers = ["Authorization"]
//    allowed_methods = ["GET"]
//    allowed_origins = ["*"]
//    max_age_seconds = 3000
//  }
//}
