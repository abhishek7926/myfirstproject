output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "threesixtyfeedback_id" {
  value = "${module.360feedback_instance.instance_id}"
}
