variable "private_dns_zone_name" {}

variable "lb_name" {
}

variable "elb_subnet" {
}

variable "elb_sg_id" {
}
variable "elb_connection_draining" { type="map" }

variable "listener" {type="list"
default =
[
  {
    listener_instance_port="80"
    listener_instance_protocol="HTTP"
    listener_lb_port="80"
    listener_lb_protocol="HTTP"
  },
  {
    listener_instance_port="443"
    listener_instance_protocol="HTTPS"
    listener_lb_port="443"
    listener_lb_protocol="HTTPS"
  },
]}

variable "elb_idle_timeout" { }

variable "is_internal"{default="false"}


variable "ssl_certificate_id" {
}

variable "health_check" {
type="map"
}


variable "elb_logs" {
  type="map"
}

variable "notification_sns_arn" {}
