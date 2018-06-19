


output "instance_id" {
  value = "${aws_instance.instance.id}"
}

output "public_ip" {
  value = "${aws_instance.instance.public_ip}"
}

output "instance_name" {
  value = "${aws_instance.instance.tags.Name}"
}

output "instance_az" {
  value = "${aws_instance.instance.availability_zone}"
}