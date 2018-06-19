module "disha_online_env" {
  source = "./../modules/env"

  ####### general ################
  env = "disha-online"
  ## used in userdata of autoscaling groups
  ansible_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDel87KUbKTM4JggXJqFKN2OfIe6xpUWYyEjJIzlS0mabo6vdXtV3j4nAYZ+ZuQha1dqZCcvy45WuYL01m3pf3zUx84LQPZpJbwNRlcjsRhG+QV03uesx2XwqLXvY1kbiKTeK9caPyKLJ+vLum3oh9YtFGOOno+F60G0V2I64Zgupn7ZsgaBoLZ44NHJWj6As6W5SNzgQhtb/ivZzV1xINkl/101Af2ANNkcjTFr3LGNqgEM19Y0o3+xtNxFI7zf8ggTAMlHhRZZhbG6iK9vYKHzQ1Q+E53yvMWO+o3Y/uyR+lBmVSnpaoolR4FpB22aR3N/R4eoz2KMFpFfdDNXHmH"
  jenkins_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6kBxZKU2FFRHQf+HG2s6+KCwyvFTK2IdYjcJv5eqbxlEBq/rTDNtpPztNFUd30drCCkN1FGaaHkelaRC3SUHJ49ui0QbiAQne0d1cenOHjzU1DqLuP1+pdv0PriH1hwzfsaVxe01N6tB8sqjohqZTHlKxBQjaWSlOD6gfMLKf5XN8BlGx9/jjYVibiNBsdtuUmSBYCs1qhKMvkwOkcz7Z2MhLoVG7CIZX3C7Y/y9+5ES5+Rps/pORG9YFRXrza0gvJOhWhhLy2jrbxMD+LRcOZMus92ClJLH1EnpKUTx4nk1JoE8IcZ1qo4m567pf4nmAbxavM1x8/p5r5univD3z"

  key_name = "disha-online"
  public_key_path = "./disha-online.pub"
  aws_region = "ap-south-1"
  provider_profile = "disha-online"
  default_az = "ap-south-1a"
  additional_az = "ap-south-1b"
  aws_app_ami = "ami-1323767c"
  aws_maintenance_ami = "ami-422c792d"
  aws_mongo_primary_ami = "ami-da287fb5"
  aws_mongo_secondary_ami = "ami-da287fb5"
  aws_mongo_arbiter_ami = "ami-162a7d79"

  ssl-bundle = "./disha-ssl-bundle"
  ssl-private-key = "./disha-ssl-private-key"
  ssl-public-key = "./disha-ssl-public-key"
  logs_bucket_name = "disha-online-logs"
  devops_bucket_name = "disha-online-devops"


  ############################### eips ###################################

  eips = {
    nat = "eipalloc-3c9fd112"
    openvpn = "eipalloc-c7cf87e9"
    jump_box = "eipalloc-b5c0889b"
    location = "eipalloc-09cc8427"
    jenkins = "eipalloc-73ce865d"

  }

  ####### vpc ####################
  vpc_name = "disha-online-vpc"
  vpc_cidr = "20.0.0.0/16"
  application_subnet_cidr = "20.0.0.0/24"
  additional_application_subnet_cidr = "20.0.1.0/24"

  maintenance_subnet_cidr = "20.0.2.0/24"
  additional_maintenance_subnet_cidr = "20.0.3.0/24"

  public_subnet_cidr = "20.0.4.0/24"
  additional_public_subnet_cidr = "20.0.5.0/24"


  private_dns_zone_name = "onlinepvt"
  public_dns_zone_name = "pmgdisha.online"
  is_info_new_domain = "1"
  public_dns_info_zone_name = "mettl.online"


  ############# Instance Type ##################################################
  nfs_instance_type = "t2.medium"
  redis_instance_type="r3.large"
  disha_web_tcmap_instance_type="t2.micro"
  openvpn_instance_type = "t2.micro"
  jenkins-ansible_instance_type = "t2.small"
  disha_mongo_primary_instance_type = "t2.medium"
  disha_mongo_secondary_instance_type = "t2.medium"
  disha_mongo_arbiter_instance_type = "t2.micro"
  username_instance_type = "t2.medium"
  disha_ifsc_instance_type = "t2.small"
  disha_eligibility_instance_type = "t2.large"
  disha_location_instance_type = "t2.medium"
  pmgdisha_info_instance_type = "t2.medium"
  biometric_instance_type = "m4.large"
  biometric_admin_instance_type = "m4.large"
  certificate_instance_type = "t2.small"
  reporting_database_updator_instance_type = "t2.large"
  metabase_instance_type = "t2.large"
  practice_instance_type = "t2.micro"
  circuit_breaker_instance_type = "t2.medium"

  nfs_snapshot_id = "snap-0c9ec9851dc6ac43f"

  enable_monitoring=0

  ######## Autoscaling #############
  disha_cms = {

    lc_ami = "ami-28a4f147"
    #lc_instance_type = "r3.large"
    lc_instance_type = "r3.large"
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

    lc_ami = "ami-87a6f3e8"
    lc_instance_type = "c4.xlarge"
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
  acm-arn = "arn:aws:acm:ap-south-1:044611426596:certificate/b861c556-5b76-4e59-badb-1e7caa8d63d5"
  info-acm-arn = "arn:aws:acm:ap-south-1:044611426596:certificate/b0f38379-d500-46cd-801c-f957c1307b37"
  ses_rule_name = "online-pmgdishamail-in"
  ses_recipients_email = "goahead@online.pmgdishamail.in"
  verifycenter_ses_rule_name = "verifycenter-pmgdishamail-in"
  verifycenter_ses_recipients_email = "verifycenter@online.pmgdishamail.in"
  aws_account_number = "044611426596"
  report_redshift_required = "1"
  report_redshift_type = "dc1.large"
  redshift_timeout_value = "900000"
  elastic_redis_cluster_type = "cache.r4.large"

  ######## S3 buckets #############
  disha_document_bucket_name = "disha-online-document"
  disha_email_bucket_name = "disha-online-email"
  student_certificates_bucket_name = "disha-online-student-certificates"
  disha_cms_bucket_name = "disha-online-cms-resources"
  disha_web_bucket_name = "disha-online-web-resources"
  certificates_sign_zip_bucket_name = "disha-online-certificates-sign-zip"
  reporting_data_bucket_name = "disha-online-reporting-data"

}