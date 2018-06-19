resource "aws_instance" "jenkins-ansible-instance" {
  instance_type = "${var.jenkins-ansible_instance_type}"
  ami = "${var.aws_maintenance_ami}"
  key_name = "${module.vpc.auth_id}"
  vpc_security_group_ids = ["${module.vpc.default_sg_id}","${aws_security_group.ansible_sg.id}"]
  subnet_id = "${module.vpc.public_subnet_id}"
  user_data         =  "${data.template_file.ansible_userdata_as_template.rendered}"
  iam_instance_profile = "${aws_iam_instance_profile.ansible-profile.id}"

  tags {
    Name        = "${var.env}-jenkins-ansible",
    Environment = "${format("%s", lower("${var.env}"))}",
    Cluster     = "${format("%s", lower("${var.instance_cluster_tag}"))}"
  }
}
data "template_file" "ansible_userdata_as_template" {
  template = "${file("../documents/userdata/ansible-userdata.sh")}"
  vars {
    deployement_env = "${var.env}"
    devops_bucket_name = "${var.devops_bucket_name}"
  }
}
resource "aws_security_group" "ansible_sg" {
  name        = "${var.env}-jenkins-ansible"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress{
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }
  ingress{
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


}

resource "aws_route53_record" "jenkins_dns" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name ="${format("%s", lower("jenkins"))}"
  type = "A"
  ttl = "60"
  records = ["${aws_instance.jenkins-ansible-instance.private_ip}"]
}
resource "aws_route53_record" "ansible_dns" {
  zone_id = "${module.vpc.private_route53_zone_id}"
  name ="${format("%s", lower("ansible"))}"
  type = "A"
  ttl = "60"
  records = ["${aws_instance.jenkins-ansible-instance.private_ip}"]
}


resource "aws_iam_role" "ansible-role" {
  name = "${var.env}-ansible-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ansible-cloudwatch-policy-attachment" {
  policy_arn = "${aws_iam_policy.cloudwatch-policy.arn}"
  role = "${aws_iam_role.ansible-role.id}"
}

resource "aws_iam_instance_profile" "ansible-profile" {
  name = "${var.env}-ansible-profile"
  role = "${var.env}-ansible-role"
}
resource "aws_iam_role_policy" "ansible-policy" {
  name = "${var.env}-ansible-policy"
  role = "${aws_iam_role.ansible-role.id}"
  policy = "${data.template_file.ansible_jenkins_policy_as_template.rendered}"

}

data "template_file" "ansible_jenkins_policy_as_template" {
  template = "${file("../documents/iam-policy/ansible-jenkins-iam-role-policy")}"
  vars {
    env = "${var.env}"
    aws_region = "${var.aws_region}"
    aws_account_number = "${var.aws_account_number}"
    reportDbInstance_id = "${module.reporting_database_updator_instance.instance_id}"
    disha_cms_bucket_name = "${var.disha_cms_bucket_name}"
    disha_web_bucket_name = "${var.disha_web_bucket_name}"
    certificate-lambda-name = "${var.certificate-lambda-name}"
    digilocker-lambda-name =  "${var.digilocker-lambda-name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "ansible_jenkins_instance_status_check" {
  alarm_name          = "${var.env}-jenkins-ansible-status-checks-failed"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "1"
  alarm_description = "This metric monitors ec2 status checks"
  alarm_actions     =["${module.disha_sns.sns_arn}"]
  insufficient_data_actions=["${module.disha_sns.sns_arn}"]
  ok_actions=["${module.disha_sns.sns_arn}"]
  dimensions {
    InstanceId = "${aws_instance.jenkins-ansible-instance.id}"
  }
}


module "ansible_instance-disk-utilization" {
  source = "../monitoring/disk_utilization/disk_utilization_instance"
  enable_monitoring="${var.enable_monitoring}"
  disk_paths = "${var.maintenance_ami_disk_paths}"
  monitoring_params = {
    threshold = 80
    period = 60
    evaluation_period = 1
  }
  alarm_notification_arn = "${module.disha_sns.sns_arn}"
  instance_id = "${aws_instance.jenkins-ansible-instance.id}"
  instance_name = "${aws_instance.jenkins-ansible-instance.tags.Name}"
  env = "${var.env}"
}
module "ansible_instance-inode-utilization" {
  source = "../monitoring/inodes/inodes_instance"
  enable_monitoring="${var.enable_monitoring}"
  disk_paths = "${var.maintenance_ami_disk_paths}"
  monitoring_params = {
    threshold = 80
    period = 60
    evaluation_period = 1
  }
  alarm_notification_arn = "${module.disha_sns.sns_arn}"
  instance_id = "${aws_instance.jenkins-ansible-instance.id}"
  instance_name = "${aws_instance.jenkins-ansible-instance.tags.Name}"
  env = "${var.env}"
}
//module "ansible_instance-load-average" {
//  source = "../monitoring/load_average/load_average_instance"
//  enable_monitoring="${var.enable_monitoring}"
//  monitoring_params = {
//    threshold = 0.8
//    period = 60
//    evaluation_period = 1
//  }
//  instance_id = "${aws_instance.jenkins-ansible-instance.id}"
//  instance_name = "${aws_instance.jenkins-ansible-instance.tags.Name}"
//  alarm_notification_arn = "${module.disha_sns.sns_arn}"
//  env = "${var.env}"
//}
module "ansible_instance-memory" {
  source = "../monitoring/memory_utilization/memory_utilization_instance"
  enable_monitoring="${var.enable_monitoring}"
  monitoring_params = {
    threshold = 80
    period = 60
    evaluation_period = 1
  }
  instance_id = "${aws_instance.jenkins-ansible-instance.id}"
  instance_name = "${aws_instance.jenkins-ansible-instance.tags.Name}"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"
  env = "${var.env}"
}

module "ansible_instance-swap" {
  source = "../monitoring/swap_utilization/swap_utilization_instance"
  enable_monitoring="${var.enable_monitoring}"
  monitoring_params = {
    threshold = 80
    period = 60
    evaluation_period = 1
  }
  instance_id = "${aws_instance.jenkins-ansible-instance.id}"
  instance_name = "${aws_instance.jenkins-ansible-instance.tags.Name}"
  alarm_notification_arn = "${module.disha_sns.sns_arn}"
  env = "${var.env}"
}