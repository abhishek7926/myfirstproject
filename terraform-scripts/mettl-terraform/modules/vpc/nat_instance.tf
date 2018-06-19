//resource "aws_instance" "nat" {
//  instance_type = "m4.large"
//  ami =  "${var.nat_ami}"
//  key_name = "${aws_key_pair.auth.id}"
//  vpc_security_group_ids = ["${aws_security_group.default-sg.id}","${aws_security_group.nat_sg.id}"]
//  subnet_id = "${aws_subnet.public_subnet.id}"
//  source_dest_check = "false"
//  user_data = "${file("../documents/userdata/autoscaling/nat-userdata")}"
//  tags {
//    Name        = "${format("%s", lower("nat.${var.private_dns_zone_name}"))}",
//    Environment = "${format("%s", lower("${var.private_dns_zone_name}"))}",
//    Cluster     = "${format("%s", lower("${var.instance_cluster_tag}"))}"
//  }
//}
//
//resource "aws_security_group" "nat_sg" {
//
//  name = "${format("%s", lower("nat_sg.${var.private_dns_zone_name}"))}"
//  description = "Nat sg"
//  vpc_id = "${aws_vpc.vpc.id}"
//
//  # SSH access from anywhere
//  ingress {
//    from_port = 22
//    to_port = 22
//    protocol = "tcp"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//  ingress {
//    from_port = 2525
//    to_port = 2525
//    protocol = "tcp"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//  ingress {
//    ##### for smtp from zabbix
//    from_port = 587
//    to_port = 587
//    protocol = "tcp"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//  ingress{
//    from_port = 80
//    to_port = 80
//    protocol = "tcp"
//    cidr_blocks = ["${var.vpc_cidr}"]
//  }
//## gerrit
//ingress{
//from_port = 29418
//to_port = 29418
//protocol = "tcp"
//cidr_blocks = ["${var.vpc_cidr}"]
//}
//  ingress{
//    from_port = 443
//    to_port = 443
//    protocol = "tcp"
//    cidr_blocks = ["${var.vpc_cidr}"]
//  }
//  ##nginx
//  ingress{
//    from_port = 8081
//    to_port = 8081
//    protocol = "tcp"
//    cidr_blocks = ["${var.vpc_cidr}"]
//  }
//  ingress{
//    from_port = 1433
//    to_port = 1433
//    protocol = "tcp"
//    cidr_blocks = ["${var.vpc_cidr}"]
//  }
//  ingress{
//    from_port = 465
//    to_port = 465
//    protocol = "tcp"
//    cidr_blocks = ["${var.vpc_cidr}"]
//  }
//  egress {
//    from_port = 0
//    to_port = 0
//    protocol = "-1"
//    cidr_blocks = [
//      "0.0.0.0/0"]
//  }
//
//}
//
//resource "aws_route53_record" "nat_dns" {
//  zone_id = "${aws_route53_zone.private_dns_zone.zone_id}"
//  name = "nat"
//  type = "A"
//  ttl = "60"
//  records = ["${aws_instance.nat.private_ip}"]
//
//}
//
//resource "aws_cloudwatch_metric_alarm" "nat_instance_status_check" {
//  alarm_name          = "${format("%s", lower("nat.${var.private_dns_zone_name}-status-checks-failed"))}"
//  comparison_operator = "GreaterThanOrEqualToThreshold"
//  evaluation_periods  = "1"
//  metric_name         = "StatusCheckFailed"
//  namespace           = "AWS/EC2"
//  period              = "60"
//  statistic           = "Average"
//  threshold           = "1"
//  alarm_description = "This metric monitors ec2 status checks"
//  alarm_actions     =["${var.sns_arn}"]
//  insufficient_data_actions=["${var.sns_arn}"]
//  ok_actions=["${var.sns_arn}"]
//  dimensions {
//    InstanceId = "${aws_instance.nat.id}"
//  }
//}
