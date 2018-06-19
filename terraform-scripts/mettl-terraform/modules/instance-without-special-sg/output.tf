output "instance_id" {
  value = "${aws_instance.instance-without-special-sg.id}"
}
output "public_ip" {
  value = "${aws_instance.instance-without-special-sg.public_ip}"
}

output "instance_name" {
  value = "${aws_instance.instance-without-special-sg.tags.Name}"
}