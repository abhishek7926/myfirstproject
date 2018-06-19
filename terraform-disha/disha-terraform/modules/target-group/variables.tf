variable "alb_tg_name" {}
variable "alb_tg_port" {}
variable "alb_tg_protocol" {}
variable "alb_tg_vpc_id" {}
variable "notification_sns_arn" {}
variable "health_check" {
type = "map"
}
variable "env" {}