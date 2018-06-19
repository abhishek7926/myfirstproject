module "disha_website_env" {
  source = "./../modules/env"

  ####### general ################
  env = "disha-website"
  ## used in userdata of autoscaling groups
  ansible_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsuH2Q46GdF30+9TVpfJG8J+9sL1QKkZQtTQ8PstlKiWpWrQX0WORr79qiKlvKng1L8Y51PNwWhftKWNgI+/oXvGhJyDNsL5FhRX656vqXJxvvq51FXRfKg8pJ3MkOXXli25ISbbJpPbftlr1Xg//3oTMFTnEOPQNvhs5tYJkIsfU19lqhMNVp7mPqKCw+osyCB8NxayhFrapsFcEq74nCxeF3TVBL+XIplxP0V9G3jElqU+NteMI2lA5rdNxtmXeU3awof28V94rXYNIMkcLskW/D6v3GQNXTvzUF1aZGsqH9/RO3uAIKsmKCqJpvE5OCQfXtqRfc4VR4Msfm8K99"
  jenkins_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSltiMJ5hewLXt4QEka5guOM7ryg9aIj2jPlevkrLVO+RsYtdwm9mcDu6/cQF4lthxXczcA/8kDLMOdAdYWHaFnZ1zTPXKoyGdpabWl/z6v/M500Xy5qpSPVmZZ0P9lEfUVHhqTax3yl/szXPsOa2FiGsgKjbXSIsC7bFFCMpkelMPlHh2pKKdL8VdjWT8XlUfTrzqlJPUzqBvaTfbis9dPFt5lWZc8k8iL//lcsLWykblHeA3bso+Tj8lrB+ok/p2pQkhtq9nekUJbveb4UFS3BNmBPaeNn64E5lZASfZndELTVfVQZ05qdAphThV1ag6U9lcn1MbQ6wGA1kHTMev"

  key_name = "disha-website"
  public_key_path = "./disha-website.pub"
  aws_region = "ap-south-1"
  provider_profile = "disha-website"
  default_az = "ap-south-1a"
  additional_az = "ap-south-1b"
  aws_app_ami = "ami-f21a529d"
  aws_maintenance_ami = "ami-1a074f75"
  aws_mongo_ami = "ami-e3074f8c"
  cms_wordpress_ami = "ami-55a3f23a"

  ssl-bundle = "./disha-ssl-bundle"
  ssl-private-key = "./disha-ssl-private-key"
  ssl-public-key = "./disha-ssl-public-key"
  logs_bucket_name = "disha-website-logs"
  devops_bucket_name = "disha-website-devops"
  vpc_id = "vpc-db39c0b3"

  ############################### eips ###################################

  eips = {
    nat = "eipalloc-c46e29ea"
    openvpn = "eipalloc-396c2b17"
    jump_box = "eipalloc-ec6d2ac2"
    location = "eipalloc-49692e67"
    jenkins = "eipalloc-e86c2bc6"
    eligibility= "eipalloc-d0cefefe"
    certificate= "eipalloc-da7043f4"
    web-tcmap= "eipalloc-cb7645e5"
  }

  ####### vpc ####################
  vpc_cidr = "10.10.0.0/16"
  application_subnet_cidr = "10.10.1.0/24"
  additional_application_subnet_cidr = "10.10.2.0/24"

  maintenance_subnet_cidr = "10.10.3.0/24"
  additional_maintenance_subnet_cidr = "10.10.4.0/24"

  public_subnet_cidr = "10.10.5.0/24"
  additional_public_subnet_cidr = "10.10.6.0/24"


  private_dns_zone_name = "websitepvt"
  public_dns_zone_name = "pmgdisha.website"
  is_info_new_domain = "0"
  public_dns_info_zone_name = ""
  biometric_domain = "csc-gov.pmgdisha.website"
  biometric_admin_domain = "admin.csc-gov.pmgdisha.website"


  ############# Instance Type ##################################################
  nfs_instance_type = "t2.medium"
  redis_instance_type="t2.small"
  disha_web_tcmap_instance_type="t2.micro"
  openvpn_instance_type = "t2.micro"
  jenkins-ansible_instance_type = "t2.micro"
  disha_mongo_instance_type = "t2.micro"
  username_instance_type = "c4.large"
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
  circuit_breaker_instance_type = "t2.medium"
  cms_wordpress_instance_type = "t2.medium"
  data-processing-engine_instance_type = "t2.micro"
  nfs_snapshot_id = "snap-0262fe3a529232093"

  enable_monitoring=0
  username_instance_ebs_optimized = "true"

  ######## Autoscaling #############
  disha_cms = {

    lc_ami = "ami-0e4a0261"
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

    lc_ami = "ami-c9baf2a6"
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
  acm-arn = "arn:aws:acm:ap-south-1:463780128272:certificate/64a65459-1d81-4b2f-a601-b5b3d1fc7089"
  ses_rule_name = "website-pmgdishamail-in"
  ses_recipients_email = "goahead@website.pmgdishamail.in"
  verifycenter_ses_rule_name = "verifycenter-pmgdishamail-in"
  verifycenter_ses_recipients_email = "verifycenter@website.pmgdishamail.in"
  aws_account_number = "463780128272"
  report_redshift_required = "1"
  report_redshift_type = "dc1.large"
  redshift_timeout_value = "900000"

  ######## S3 buckets #############
  disha_document_bucket_name = "disha-website-document"
  disha_email_bucket_name = "disha-website-email"
  student_certificates_bucket_name = "disha-website-student-certificates"
  disha_cms_bucket_name = "disha-website-cms-resources"
  disha_web_bucket_name = "disha-website-web-resources"
  certificates_sign_zip_bucket_name = "disha-website-certificates-sign-zip"
  reporting_data_bucket_name = "disha-website-reporting-data"
  cms_wordpress_bucket_name = "disha-website-wordpress-cms"

}