//resource "aws_iam_server_certificate" "ssl_cert" {
//  name = "${format("%s", lower("${var.env}-ssl-cert"))}"
//  certificate_body = "${file(var.ssl-public-key)}"
//  private_key = "${file(var.ssl-private-key)}"
//  certificate_chain="${file(var.ssl-bundle)}"
//}