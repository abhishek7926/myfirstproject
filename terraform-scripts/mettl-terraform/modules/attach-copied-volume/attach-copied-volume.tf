resource "aws_ebs_volume" "ebs_from_snapshot" {
  availability_zone = "${var.default_az}"
  snapshot_id="${var.snapshot_id}"
  type="${var.volume_type}"
  tags {
    Name = "${var.instance_name}"
  }
}


resource "aws_volume_attachment" "attach_ebs_created_from_snapshot" {
  device_name = "${var.device_name}"
  volume_id = "${aws_ebs_volume.ebs_from_snapshot.id}"
  instance_id = "${var.instance_id}"
}