#################################################################################
variable "public_key_path" { }
variable "key_name" { }
variable "aws_region" { }
variable "provider_profile" {}
variable "env" {}
variable "ansible_pub_key" {}
variable "jenkins_pub_key" {}
variable "logs_bucket_name" {}
variable "vpc_id" {}
variable "vpc_igw_id" {}

######################################## VPC module variables ########################################
variable "application_subnet_cidr" {}
variable "additional_application_subnet_cidr" {}
variable "public_subnet_cidr" {}
variable "additional_public_subnet_cidr" { }
variable "vpc_cidr" {}
variable "maintenance_subnet_cidr" {}
variable "additional_maintenance_subnet_cidr" {}
variable "private_dns_zone_name" {}
variable "public_dns_zone_name" {}
variable "default_az" {}
variable "additional_az" {}
variable "is_info_new_domain" {}
variable "public_dns_info_zone_name" {}
variable "biometric_subdomain" {}
variable "biometric_admin_subdomain" {}
variable "certificate_subdomain" {}
variable "reports_subdomain" {}
variable "practice_subdomain" {}
variable "turbine_subdomain" {}
variable "digilocker-lambda-name" {}
variable "certificate-lambda-name" {}

#variable "disha_cms_alb_name" {}
################################### instance types #################################
variable "nfs_instance_type" {}
variable "redis_instance_type"{}
variable "disha_web_tcmap_instance_type" {}
variable "openvpn_instance_type" {}
variable "jenkins-ansible_instance_type" {}
variable "disha_mongo_primary_instance_type" {}
variable "disha_mongo_secondary_instance_type" {}
variable "disha_mongo_arbiter_instance_type" {}
variable "username_instance_type" {}
variable "disha_ifsc_instance_type" {}
variable "disha_eligibility_instance_type" {}
variable "disha_location_instance_type" {}
variable "pmgdisha_info_instance_type" {}
variable "biometric_instance_type" {}
variable "biometric_admin_instance_type" {}
variable "certificate_instance_type" {}
variable "reporting_database_updator_instance_type" {}
variable "metabase_instance_type" {}
variable "practice_instance_type" {}
variable "circuit_breaker_instance_type" {}
variable "cms_wordpress_instance_type" {}
variable "nfs_snapshot_id" {}
variable "devops_bucket_name" {}

variable "is_internal" {default="false"}

variable "aws_mongo_primary_ami" {}
variable "aws_mongo_secondary_ami" {}
variable "aws_mongo_arbiter_ami" {}
variable "aws_app_ami" {}
variable "aws_maintenance_ami" {}
variable "cms_wordpress_ami" {}
variable "instance_cluster_tag" {default="Maintenance"}
variable "username_instance_ebs_optimized" {}
variable "data-processing-engine_instance_type" {}
########################################MONITORING####################
variable "enable_monitoring" {}

variable "maintenance_ami_disk_paths" {
  type="list"
  default=[
    {
      Filesystem="/dev/xvda1"
      MountPath="/boot"
    },
    {
      Filesystem="/dev/mapper/vg0-lv_root"
      MountPath ="/"
    }
  ]
}

variable "disha_cms_disk_paths" {
  type="list"
  default=[
    {
      Filesystem="/dev/xvda1"
      MountPath="/boot"
    },
    {
      Filesystem="/dev/mapper/vg0-lv_mettl_logs"
      MountPath="/home/mettl/mettl_logs"
    },
    {
      Filesystem="/dev/mapper/vg0-lv_root"
      MountPath ="/"
    },
    {
      Filesystem="/dev/mapper/vg0-lv_mettl_volume1"
      MountPath="/home/mettl/volume1"
    }
  ]
}

variable "disha_web_disk_paths" {
  type="list"
  default=[
    {
      Filesystem="/dev/xvda1"
      MountPath="/boot"
    },
    {
      Filesystem="/dev/mapper/vg0-lv_mettl_logs"
      MountPath="/home/mettl/mettl_logs"
    },
    {
      Filesystem="/dev/mapper/vg0-lv_root"
      MountPath ="/"
    },
    {
      Filesystem="/dev/mapper/vg0-lv_mettl_volume1"
      MountPath="/home/mettl/volume1"
    }
  ]
}

########################################## preoccupied eips #######################################
variable "eips" {type="map"}

########################################## AUTOSCALING #############################################################
variable "disha_web" {type="map"}
variable "pmgdisha-info" {type="map"}
variable "acm-arn" {}
variable "additional_ssl_arn" {type = "list"}
variable "info-acm-arn" {}
variable "ses_rule_name" {}
variable "ses_recipients_email" {}
variable "verifycenter_ses_rule_name" {}
variable "verifycenter_ses_recipients_email" {}
variable "aws_account_number" {}
variable "elastic_redis_cluster_type" {}

########################################## S3 buckets #############################################################
variable "disha_document_bucket_name" {}
variable "disha_email_bucket_name" {}
variable "student_certificates_bucket_name" {}
variable "disha_cms_bucket_name" {}
variable "disha_web_bucket_name" {}
variable "certificates_sign_zip_bucket_name" {}
variable "reporting_data_bucket_name" {}
variable "cms_wordpress_bucket_name" {}
