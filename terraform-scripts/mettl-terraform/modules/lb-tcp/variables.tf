variable "private_dns_zone_name" {}

variable "lb_name" { }
variable "elb_subnet" { }
variable "elb_sg_id" { }
variable "listener" {type="list"}
variable "health_check" { type="map" }
variable "is_internal"{default="true"}
variable "elb_idle_timeout" { }
variable "elb_connection_draining" { type="map" }
variable "elb_logs" {
  type="map"
}
variable "notification_sns_arn" {}
