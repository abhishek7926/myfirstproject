variable "alb_name" {}
variable "is_internal" {default = false}
variable "alb_sg_id" {type = "list"}
variable "alb_subnets" {type = "list"}
variable "alb_logs" {type = "map"}
variable "env" {}

