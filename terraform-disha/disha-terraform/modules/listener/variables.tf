variable "alb_arn" {}
variable "alb_tg_http_arn" {}
variable "alb_tg_https_arn" {}
variable "ssl_certificate_arn" {}
variable "additional_ssl_arn" {type = "list"}
variable "listener" {type="list"
  default =
  [
    {
      listener_port="80"
      listener_protocol="HTTP"
      listener_type="forward"
    },
    {
      listener_port="443"
      listener_protocol="HTTPS"
      listener_type="forward"
    },
  ]}

variable "listener_arn_http" {}
variable "base_priority_http" {}
variable "count_rules_http" {}
variable "rules_http" {type="list"}

variable "listener_arn_https" {}
variable "base_priority_https" {}
variable "count_rules_https" {}
variable "rules_https" {type="list"}