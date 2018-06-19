resource "aws_ebs_volume" "raw_ebs" {
  availability_zone = "${var.default_az}"
  size = "${var.size}"
  type="${var.volume_type}"
  tags {
    Name = "${var.instance_name}"  }
}


resource "aws_volume_attachment" "attach_raw_ebs" {
  device_name = "${var.device_name}"
  volume_id = "${aws_ebs_volume.raw_ebs.id}"
  instance_id = "${var.instance_id}"
}