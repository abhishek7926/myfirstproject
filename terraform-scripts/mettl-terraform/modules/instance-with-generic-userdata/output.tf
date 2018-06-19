output "instance_id" {
  value = "${aws_instance.instance-with-generic-userdata.id}"
}
output "public_ip" {
  value = "${aws_instance.instance-with-generic-userdata.public_ip}"
}
output "instance_name" {
  value = "${aws_instance.instance-with-generic-userdata.tags.Name}"
}