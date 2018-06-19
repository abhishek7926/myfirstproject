variable "count" {}
variable "app" { }
variable "lc_ami" {}
variable "lc_instance_type" {}
variable "lc_sg" { type="list" }
variable "instance_authorization_key" { }
variable "iam_instance_profile" {}
variable "associate_public_ip_address" { default = false }
variable "stunServerAddress" {default=""}
variable "stunServerPort" {default=""}
variable "turnURL" {default=""}
variable "turnURLPort" {default=""}
variable "env" {}
variable "user_data" { }
variable "ansible_public_key" {default=""}
variable "jenkins_public_key" {default=""}
variable "lc_ebs" {type="list"}
//variable "enable_monitoring" {}