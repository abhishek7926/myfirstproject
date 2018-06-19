module "disha_de_env" {
  source = "./../modules/env"

  ####### general ################
  env = "disha-de"
  ## used in userdata of autoscaling groups
  ansible_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOURKMMV1Dsw/5jENhibDStJ/AzYtEfUe9AdVI4LPawCb/Z37CB8otfq+iFQMk6aJSwfkrSZ2f9/gaMTrJDyHX9gBC8goUru6LbpZ3NErWSWreMSlFvt4dm9kwyt4OZfB+3vGDv2VvNc1j8twTPZqnAW2zKemp351ZYNUosI7/IPwGIEzxOpO2Mj9yimsvAo1BpphhHBs5wMExtzM81uExeSEO4fqIoPLbOjXJGZOpVG1v8zweLzT2S6NepHy/9Snq4BgEfVhPBOJwWSSqshU+pDcB/gIMk95VTKxFdEBKyijNYVm9XEfQMZniIbdVnL4lVesjoPA2LXddMAim7c39"
  jenkins_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgORN36e24FWpNKOsF9o/6Z3F5CGj0TNE4xg9ITHRqdioFM5W9Q+lrTZv4d8SETixS7QcLODbD78zjDgoBz3SqHQNokLU85vQVzeKJJo/CWUCUzhF+s9kKEB7oueDKjKRQDkFct0j9UGt+kFeiVRgc4qglpSZaQsfpzQ7mqTcLV9Ac3NB/JRDIlzvEjMCOHCBHFF3vAHMq5f9pDsqP9IlRymRvtDaSFXvltSqMvGerx7Qf7X/xDk6EkogYHNUe2fu9O8Ij4KRhrs+dm4rAzlyR4MBccteONSanfiPQ9QbJRmUBuzrrqesAQxwteZx/l+pmAPPi1DOHsZLlK/oh+I7B"

  key_name = "disha-de-new"
  public_key_path = "./disha-de.pub"
  aws_region = "ap-south-1"
  provider_profile = "default"
  default_az = "ap-south-1a"
  additional_az = "ap-south-1b"
  aws_app_ami = "ami-5c9cbf33"
  aws_maintenance_ami = "ami-69604206"
  aws_mongo_primary_ami = "ami-df6042b0"
  aws_mongo_secondary_ami = "ami-df6042b0"
  aws_mongo_arbiter_ami = "ami-df6042b0"
  cms_wordpress_ami = "ami-ff6a4890"

//  ssl-bundle = "./disha-ssl-bundle"
//  ssl-private-key = "./disha-ssl-private-key"
//  ssl-public-key = "./disha-ssl-public-key"
  logs_bucket_name = "disha-de-logs"
  devops_bucket_name = "disha-de-devops"
  vpc_id = "vpc-6586730c"
  vpc_igw_id = "igw-4b19f622"

  ############################### eips ###################################

  eips = {
    nat = "eipalloc-52cdfe7c"
    openvpn = "eipalloc-fdc9fad3"
    jump_box = "eipalloc-f8cdfed6"
    location = "eipalloc-50cdfe7e"
    jenkins = "eipalloc-11cffc3f"
    eligibility= "eipalloc-97cefdb9"
    certificate= "eipalloc-0ac8fb24"
    web-tcmap= "eipalloc-10caf93e"
  }

  ####### vpc ####################
  vpc_cidr = "20.0.0.0/16"
  application_subnet_cidr = "20.0.5.0/24"
  additional_application_subnet_cidr = "20.0.6.0/24"

  maintenance_subnet_cidr = "20.0.7.0/24"
  additional_maintenance_subnet_cidr = "20.0.8.0/24"

  public_subnet_cidr = "20.0.10.0/24"
  additional_public_subnet_cidr = "20.0.11.0/24"


  private_dns_zone_name = "depvt"
  public_dns_zone_name = "disha.mettl.in"
  is_info_new_domain = "0"
  public_dns_info_zone_name = ""
  biometric_subdomain = "csc.mettl.de"
  biometric_admin_subdomain = "admin-csc-gov.mettl.de"
  certificate_subdomain = "certificate.mettl.in"
  reports_subdomain = "reports.mettl.in"
  practice_subdomain = "practice.mettl.de"
  turbine_subdomain = "turbine.mettl.in"


  ############# Instance Type ##################################################
  nfs_instance_type = "t2.medium"
  redis_instance_type="t2.small"
  disha_web_tcmap_instance_type="t2.micro"
  openvpn_instance_type = "t2.micro"
  jenkins-ansible_instance_type = "t2.micro"
  disha_mongo_primary_instance_type = "t2.micro"
  disha_mongo_secondary_instance_type = "t2.micro"
  disha_mongo_arbiter_instance_type = "t2.micro"
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

  disha_web = {

    lc_ami = "ami-93a689fc"
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


//  disha_cms_alb_name = "pmgdisha"
  acm-arn = "arn:aws:acm:ap-south-1:760572120597:certificate/077e18db-4353-41da-a851-5c8574f13740"
  additional_ssl_arn = ["arn:aws:iam::760572120597:server-certificate/mettl-de-june-2017", "arn:aws:iam::760572120597:server-certificate/mettl-de-june-2017-1"]
  info-acm-arn = "arn:aws:acm:ap-south-1:760572120597:certificate/742930b2-9294-4af1-b7e6-bfa046ecdd61"
  ses_rule_name = "staging-pmgdishamail-in"
  ses_recipients_email = "goahead@staging-pmgdishamail-in"
  verifycenter_ses_rule_name = "verifycenter-staging-pmgdishamail-in"
  verifycenter_ses_recipients_email = "verifycenter@staging.pmgdishamail.in"
  aws_account_number = "760572120597"
  elastic_redis_cluster_type = "cache.t2.medium"

  ######## S3 buckets #############
  disha_document_bucket_name = "de-disha-document"
  disha_email_bucket_name = "staging-pmgdishamail-in"
  student_certificates_bucket_name = "staging-disha-student-certificate"
  disha_cms_bucket_name = "disha-cms-de-resources"
  disha_web_bucket_name = "disha-web-de-resources"
  certificates_sign_zip_bucket_name = "stag-disha-certificates"
  reporting_data_bucket_name = "de-disha-reporting-data"
  cms_wordpress_bucket_name = "de-disha-cms-wordpress-bucket"

  ######## Lambda #################
  certificate-lambda-name = "De-certificate-lambda"
  digilocker-lambda-name = "de-disha-digilocker-certificate-lambda"

}