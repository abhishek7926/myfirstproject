module "me_disha_env" {
  source = "./../modules/env"

  ####### general ################
  env = "me-disha"
  ## used in userdata of autoscaling groups
  ansible_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCbBJWHQfbWdylZoea/dhtKmlOuw1zoflF3wH6W0crorGRO/WBEl7riW+hcTsjFJAYowNFB+ODgTdzQhAINyviMLsG2gYwTCe+gmlkRPgelDbR7TkgrZuW+vEsUMnW8ZvbCywhxg6Ib3MONO9XwH84ivBP3VvISnBVq+ZPClPo2YC5bNlx7x7nj5APs+Vs2B3dk234vVM5E7aiFokf7bEK9Vg+I2hPuUJEe3Mq9T8U8Y/Ef2I/46xoDpLdlYtp3HRo2xRQ+oPaYySR7iCZv8nzzcgK45pGIgcY7XuNBmZjDRHpzTQAeFFy5HmKqmkeswSO2WsgxA7CT5STcaz+aGJ/D"
  jenkins_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCn0mOYGK2unajnDa+NZq+kKCplr3S1prtiWyQplSlLdnOZiiXxcSy2/6jobc0nzbr6N2BVNgIkBwZdeVWVXj0Qga9dulLvCONBVbrh/Q65PFzmbr4AnO/d/4Bi1DoS02uaqGGCbBjEMehgp1R8xdaSWFWy7LySnfXAc4mH+EZYuc8Tibb9HziitMF5QtuovqryCI6/wDKR6y4CUdTBKWYIZkNuqQN+OUcCmkMBiLg2qty2Pf49UyHJujopykETQBK5d08eQj2w4gFaKyVPmUViLb4Am5unyMv6xVzPP4f58naqowXmj2KvuTnQPrG+rD1mmHV8sEajyL+euH7EV3d5"

  key_name = "me-disha"
  public_key_path = "./me-disha.pub"
  aws_region = "ap-south-1"
  provider_profile = "disha"
  default_az = "ap-south-1a"
  additional_az = "ap-south-1b"
  aws_app_ami = "ami-f6327e99"
  aws_maintenance_ami = "ami-39317d56"
  aws_mongo_ami = "ami-ee337f81"

  ssl-bundle = "./disha-ssl-bundle"
  ssl-private-key = "./disha-ssl-private-key"
  ssl-public-key = "./disha-ssl-public-key"
  logs_bucket_name = "me-disha-logs"


  ############################### eips ###################################

  eips = {
    nat = "eipalloc-69c4be47"
    openvpn = "eipalloc-1bc0ba35"
    jump_box = "eipalloc-77c1bb59"
    location = "eipalloc-8cc2b8a2"
    jenkins = "eipalloc-66c4be48"

  }

  ####### vpc ####################
  vpc_name = "me-disha-vpc"
  vpc_cidr = "10.140.0.0/16"
  application_subnet_cidr = "10.140.1.0/24"
  additional_application_subnet_cidr = "10.140.2.0/24"

  maintenance_subnet_cidr = "10.140.3.0/24"
  additional_maintenance_subnet_cidr = "10.140.4.0/24"

  public_subnet_cidr = "10.140.5.0/24"
  additional_public_subnet_cidr = "10.140.6.0/24"


  private_dns_zone_name = "mepvt"
  public_dns_zone_name = "pmgdisha.me"

  ############# Instance Type ##################################################
  nfs_instance_type = "t2.medium"
  redis_instance_type="t2.small"
  disha_web_tcmap_instance_type="t2.micro"
  openvpn_instance_type = "t2.micro"
  jenkins-ansible_instance_type = "t2.micro"
  disha_mongo_instance_type = "t2.micro"
  username_instance_type = "t2.small"
  disha_ifsc_instance_type = "t2.small"
  disha_eligibility_instance_type = "t2.small"
  disha_location_instance_type = "t2.micro"
  pmgdisha_info_instance_type = "t2.micro"
  biometric_instance_type = "t2.micro"
  biometric_admin_instance_type = "t2.micro"
  certificate_instance_type = "t2.small"
  reporting_database_updator_instance_type = "t2.large"
  metabase_instance_type = "t2.large"
  practice_instance_type = "t2.small"

  nfs_snapshot_id = "snap-007e2bb57875aa888"

  enable_monitoring=0

  ######## Autoscaling #############
  disha_cms = {

    lc_ami = "ami-ccd699a3"
    #lc_instance_type = "r3.large"
    lc_instance_type = "t2.micro"
    user_data_file_name = "../documents/userdata/disha_cms-userdata"
    as_max_size = "10"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "100"
    health_check_type = "ELB"
    health_check_response_timeout = "5"
    health_check_interval = "29"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
  }

  disha_web = {

    lc_ami = "ami-59d89736"
    lc_instance_type = "r3.large"
    user_data_file_name = "../documents/userdata/disha_web-userdata"
    as_max_size = "10"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    health_check_response_timeout = "5"
    health_check_interval = "29"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
  }

  pmgdisha-info = {
    health_check_response_timeout = "4"
    health_check_interval = "5"
    elb_logs_interval = "60"
    elb_logs_enabled = "true"
  }


  disha_cms_alb_name = "pmgdisha"
  ssl_policy = ""
  acm-arn = "arn:aws:acm:ap-south-1:778504583090:certificate/783cda45-998a-4d5a-9f7e-dca83e44ed6d"
  ses_rule_name = "me-pmgdishamail-in"
  ses_recipients_email = "goahead@me.pmgdishamail.in"
  aws_account_number = "778504583090"
  report_redshift_required = "1"
  report_redshift_type = "dc1.large"

  ######## S3 buckets #############
  disha_document_bucket_name = "me-disha-disha-document"
  disha_email_bucket_name = "me-disha-disha-email"
  student_certificates_bucket_name = "me-disha-student-certificates"
  disha_cms_bucket_name = "me-disha-disha-cms"
  disha_web_bucket_name = "me-disha-disha-web"
  certificates_sign_zip_bucket_name = "me-disha-certificates-sign-zip"
  reporting_data_bucket_name = "me-disha-reporting-data"

}