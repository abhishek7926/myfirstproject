output "created_volume_size" {
  value = "${aws_ebs_volume.ebs_from_snapshot.size}"
}