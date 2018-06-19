variable "sqs_name" {}
variable "env" {}
variable "delay_time" {default = 0}
variable "max_message_size" {default = 256000}
variable "visibility_timeout" {default = 30}
variable "message_retention" {default = 345600}
variable "receive_wait_time" {default = 0}
variable "sqs_policy" {default = ""}
variable "sqs_redrive_policy" {default = ""}