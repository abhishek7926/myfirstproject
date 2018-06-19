//resource "aws_s3_bucket_notification" "notify_sqs_on_object_creation" {
//  bucket = "${var.bucket_id}"
//  queue {
//    events = ["s3:ObjectCreated:*"]
//    queue_arn = "${var.sqs_arn}"
//    filter_prefix = "${var.filter_prefix}"
//  }
//}