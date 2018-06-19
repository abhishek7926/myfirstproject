#variable "env" {}
variable "as_name" {}
variable "scale_up_consecutive_periods" {}
variable "scale_up_period" {}
variable "cpu_high_threshold" {}
variable "scale_down_consecutive_periods" {}  
variable "scale_down_period" {}  
variable "cpu_low_threshold" {}


variable "scale_down_by_instances" {}
variable "scale_up_by_instances" {}
variable "scale_up_warmup" {}
variable "alarm_notification_arn"{}
