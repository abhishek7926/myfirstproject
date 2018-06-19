output "listener_http_arn" {
  value = "${aws_alb_listener.http.arn}"
}

output "listener_https_arn" {
  value = "${aws_alb_listener.https.arn}"
}