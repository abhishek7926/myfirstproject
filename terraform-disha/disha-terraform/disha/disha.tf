module "disha_mettl_in_env" {
  source = "./../modules/env"

  ####### general ################
  env = "pmgdisha-website"
  ## used in userdata of autoscaling groups
  ansible_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCbBJWHQfbWdylZoea/dhtKmlOuw1zoflF3wH6W0crorGRO/WBEl7riW+hcTsjFJAYowNFB+ODgTdzQhAINyviMLsG2gYwTCe+gmlkRPgelDbR7TkgrZuW+vEsUMnW8ZvbCywhxg6Ib3MONO9XwH84ivBP3VvISnBVq+ZPClPo2YC5bNlx7x7nj5APs+Vs2B3dk234vVM5E7aiFokf7bEK9Vg+I2hPuUJEe3Mq9T8U8Y/Ef2I/46xoDpLdlYtp3HRo2xRQ+oPaYySR7iCZv8nzzcgK45pGIgcY7XuNBmZjDRHpzTQAeFFy5HmKqmkeswSO2WsgxA7CT5STcaz+aGJ/D"
  jenkins_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCn0mOYGK2unajnDa+NZq+kKCplr3S1prtiWyQplSlLdnOZiiXxcSy2/6jobc0nzbr6N2BVNgIkBwZdeVWVXj0Qga9dulLvCONBVbrh/Q65PFzmbr4AnO/d/4Bi1DoS02uaqGGCbBjEMehgp1R8xdaSWFWy7LySnfXAc4mH+EZYuc8Tibb9HziitMF5QtuovqryCI6/wDKR6y4CUdTBKWYIZkNuqQN+OUcCmkMBiLg2qty2Pf49UyHJujopykETQBK5d08eQj2w4gFaKyVPmUViLb4Am5unyMv6xVzPP4f58naqowXmj2KvuTnQPrG+rD1mmHV8sEajyL+euH7EV3d5"

  key_name = "disha-india"
  public_key_path = "./disha.pub"
  aws_region = "ap-northeast-1"
  provider_profile = "default"
  default_az = "ap-northeast-1a"
  additional_az = "ap-northeast-1c"
  aws_app_ami = "ami-18c3167e"
  aws_maintenance_ami = "ami-dac114bc"
  aws_mongo_ami = "ami-21f42547"

  ssl-bundle = "./disha-ssl-bundle"
  ssl-private-key = "./disha-ssl-private-key"
  ssl-public-key = "./disha-ssl-public-key"
  logs_bucket_name = "disha-mettl-in-logs"


  ############################### eips ###################################

  eips = {
    nat = "eipalloc-96d4bfac"
    openvpn = "eipalloc-d75f35ed"
    jump_box = "eipalloc-29a2c813"
    location = "eipalloc-ac1e6996"
    jenkins = "eipalloc-8f3d4bb5"

  }

  ####### vpc ####################
  vpc_name = "pmgdisha-vpc"
  vpc_cidr = "10.10.0.0/16"
  application_subnet_cidr = "10.10.1.0/24"
  additional_application_subnet_cidr = "10.10.2.0/24"

  maintenance_subnet_cidr = "10.10.3.0/24"
  additional_maintenance_subnet_cidr = "10.10.4.0/24"

  public_subnet_cidr = "10.10.5.0/24"
  additional_public_subnet_cidr = "10.10.6.0/24"


  private_dns_zone_name = "websitepvt"
  public_dns_zone_name = "pmgdisha.website"

  ############# Instance Type ##################################################
  nfs_instance_type = "t2.medium"
  redis_instance_type="t2.micro"
  disha_web_tcmap_instance_type="t2.micro"
  openvpn_instance_type = "t2.micro"
  jenkins-ansible_instance_type = "t2.micro"
  disha_mongo_instance_type = "t2.micro"
  username_instance_type = "t2.micro"
  disha_ifsc_instance_type = "t2.small"
  disha_eligibility_instance_type = "t2.micro"
  disha_location_instance_type = "t2.micro"
  pmgdisha_info_instance_type = "t2.micro"
  biometric_instance_type = "t2.micro"
  biometric_admin_instance_type = "t2.micro"
  certificate_instance_type = "t2.micro"
  reporting_database_updator_instance_type = "t2.micro"

  enable_monitoring=0

  ######## Autoscaling #############
  disha_cms = {

    lc_ami = "ami-69f8200f"
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

    lc_ami = "ami-5cf9213a"
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
  acm-arn = "arn:aws:acm:ap-northeast-1:760572120597:certificate/19e89f5c-8dab-4380-a149-c5d1b1c99169"
  s3_bucket_name = "first-bucket-by-terraform"
}