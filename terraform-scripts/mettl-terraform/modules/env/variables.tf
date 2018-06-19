#################################################################################
variable "public_key_path" { }
variable "key_name" { }
variable "aws_region" { }
variable "env" {}
variable "ansible_pub_key" {}
variable "jenkins_pub_key" {}
variable "ssl-bundle"{}
variable "ssl-private-key"{}
variable "ssl-public-key"{}
variable "logs_bucket_name" {}
variable "skill_master_data_bucket_name" {}
variable "acm_certificate_arn" {}

variable "client_archival_instance_type" {}
variable "mongo_client_archival_instance_type" {}

#################################### windows password and user ###############


variable "windows_codeproject_instance_user"{}
variable "windows_codelysis_instance_user"{}
variable "windows_codeproject_instance_password"{}
variable "windows_codelysis_instance_password"{}
variable "windows_codeproject_instance_ebs_optimized"{}
#################################### tags ####################################

variable "instance_cluster_tag"{default="Maintenance"}

################################### instance types #################################
variable "r_simulators_router_instance_type" {}
variable "reporting_metabase_instance_type" {}
variable "reporting_migrator_instance_type" {}
variable "labs_2_backend_instance_type" {}
variable "labs_instance_type" {}
variable "labs_1_backend_instance_type" {}
variable "status_mettl_instance_type" {}
variable "interviewApp_admin_frontend_instance_type" {}
variable "interviewApp_admin_backend_instance_type" {}
variable "interviewApp_candidate_frontend_instance_type" {}
variable "interviewApp_candidate_backend_instance_type" {}
variable "interviewApp_socket_instance_type" {}
variable "master_1_elasticsearch_instance_type" { }
variable "master_2_elasticsearch_instance_type" { }
variable "master_3_elasticsearch_instance_type" { }
variable "data_1_elasticsearch_instance_type" { }
variable "data_2_elasticsearch_instance_type" { }
variable "fes_instance_type" { }
variable "chat_web_socket_instance_type" {}
variable "metric_publishing_instance_type"{}
variable "application_metrics_instance_type"{}
variable "uber_instance_type" {}
variable "feedback_instance_type" {}
variable "test_notification_instance_type" {}
variable "pr_instance_type" {}
variable "fhgfs_ucl_code_project_instance_type" {}
variable "mongodb_light_member1_instance_type" {}
variable "mongodb_light_member2_instance_type" {}
variable "mongodb_light_member3_instance_type" {}
variable "corporate_instance_type"{}
variable "report_corporate_instance_type" {}
variable "mongodb_heavy_member1_instance_type" {}
variable "mongodb_heavy_member2_instance_type" {}
variable "mongodb_heavy_arbiter_instance_type" {}
variable "activemq_instance_type" {}
variable "threesixtyfeedback_instance_type" { }
variable "adminpanel_instance_type" {}
variable "kafka_instance_type" {}
variable "zabbix_instance_type" {}
variable "elk_instance_type" {}
variable "jenkins-ansible_instance_type" {}
variable "openvpn_instance_type" {}
variable "nfs_instance_type" {}
variable "redis_instance_type"{}
variable "skillmaster_instance_type"{}
variable "skillmaster_general_instance_type"{}
variable "skillmaster_special_instance_type"{}
variable "skillmaster_admin_instance_type"{}
variable "question_event_service_instance_type" {}
variable "static_instance_type" {}
variable "prelogin_instance_type"{}
variable "streaming_instance_type"{}
variable "chat_socket_instance_type"{}
variable "chat_service_instance_type"{}
variable "api_instance_type" {}
variable "certification_instance_type" {}
variable "grader_instance_type" {}
variable "excel_instance_type" {}
variable "large_excel_instance_type" {}
variable "scheduler_instance_type" {}
variable "contest_instance_type" {}
variable "api_demo_instance_type" {}
variable "lms_instance_type" {}
variable "hpe_instance_type" {}
variable "igt_instance_type" {}
variable "accenture_instance_type" {}
variable "duo_lingo_instance_type" {}
variable "notification_instance_type" {}
variable "shared_report_corporate_instance_type" {}
variable "offline_app_instance_type" {}
variable "windows_codeproject_instance_type" {}
variable "windows_codelysis_instance_type" {}
variable "client_api_instance_type" {}
variable "hackathon_instance_type" {}
######################## Intellisense instance type ###########################
variable "intellisense_router_instance_type" {}
variable "intellisense_csharp_instance_type" {}
variable "intellisense_java_instance_type" {}
variable "intellisense_python_instance_type" {}
###################################### java service instance types #################
variable "schema_instance_type" {}
variable "bulkpdf_instance_type" {}
variable "dblysis_instance_type" {}
variable "typingsimulator_instance_type" {}
variable "report_instance_type" {}
variable "htmltopdf_instance_type" {}
variable "intellisense_instance_type" {}
variable "english_simulator_instance_type" {}
variable "live_feed_router_instance_type"{}
variable "chat_activemq_instance_type" {}
variable "proctoring_instance_type" {}
variable "jobvite_instance_type" {}
variable "almdigital_instance_type" {}
######## Wordpress #######
variable "wordpress_instance_type" {}

####################################### AMI ########################################
variable "aws_app_ami" {}
variable "aws_maintenance_ami" {}
variable "aws_mongodb_light_member1_ami" {}
variable "aws_mongodb_light_member2_ami" {}
variable "aws_mongodb_light_member3_ami" {}
variable "aws_mongodb_heavy_member1_ami" {}
variable "aws_mongodb_heavy_member2_ami" {}
variable "aws_mongodb_heavy_arbiter_ami" {}
variable "aws_htmltopdf_ami" {}
variable "aws_intellisense_ami" {}
variable "aws_english_simulator_ami" {}
variable "aws_windows_codelysis_ami" {}
variable "aws_windows_codeproject_ami" {}
variable "aws_fhgfs_ami" {}
variable "wordpress_ami" {}
######################################## VPC module variables ########################################
variable "vpc_name" {}
variable "application_subnet_cidr" {}
variable "additional_application_subnet_cidr" {}
variable "ucl_subnet_cidr" {}
variable "public_subnet_cidr" {}
variable "additional_public_subnet_cidr" { }

variable "vpc_cidr" {}
variable "maintenance_subnet_cidr" {}
variable "additional_maintenance_subnet_cidr" {}
variable "private_dns_zone_name" {}
variable "public_dns_zone_name" {}
variable "default_az" {}
variable "additional_az" {}
########################################## AUTOSCALING #############################################################
variable "aui" {type="map"}
variable "report-service-api" {type="map"}
variable "assessment-service" {type="map"}
variable "pr" {type="map"}
variable "mip" {type="map"}
variable "yolo" {type="map"}
variable "coding-simulator" {type="map"}
variable "application-grader" {type="map"}
variable "proctoring-ui" {type="map"}
variable "report-ui" {type="map"}
//variable "chatweb-socket" {type="map"}
variable "scheduler-candidate-event" {type="map"}
variable "email-service" {type="map"}
variable "ucl-code-project" {type = "map"}
variable "ucl-codelysis" {type="map"}
variable "ucl-codelysis-revert" {type="map"}
variable "ucl-codelysis-android"{type="map"}
variable "question-service" {type="map"}
variable "blue-green" {type="map"}
variable "live_feed_service"{type="map"}
variable "janus_live_feed_service" {type="map"}
variable "java-codelysis"{type="map"}
variable "proxy" {type="map"}
variable "mettl-api" {type="map"}
variable "cos-api" {type="map"}
variable "mettl-api-gateway" {type="map"}
variable "r-simulator-spi" {type="map"}
variable "r-socket" {type="map"}
variable "r-simulator-cms" {type="map"}
variable "plagiarism" {type="map"}
variable "redshift_count" {}
variable "reporting_metabase_count" {}
variable "reporting_migrator_count" {}
###################################### Data services volume snapshots #################
variable "fes_snapshot_id" {}
variable "static_snapshot_id" {}
variable "fhgfs_ucl_code_project_snapshot_id"{}
variable "igt_snapshot_id" {}

########################################## preoccupied eips #######################################
variable "eips" {type="map"}
########################################## livefeed ####################################################

variable "livefeed_stun_server_address" {}
variable "livefeed_stunserver_port" {}
variable "livefeed_turn_url" {}
variable "livefeed_turnURLPort" {}

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

variable "activemq_disk_paths" {
  type="list"
  default=[
  {
  Filesystem="/dev/xvda1"
  MountPath="/boot"
  },
  {
  Filesystem="/dev/mapper/vg0-lv_root"
  MountPath ="/"
  },
{
Filesystem="/dev/xvdc"
MountPath ="/activemq"
}
  ]
}


variable "es_disk_paths" {
  type="list"
  default=[
    {
      Filesystem="/dev/xvda1"
      MountPath="/boot"
    },
    {
      Filesystem="/dev/mapper/vg0-lv_root"
      MountPath ="/"
    },
    {
      Filesystem="/dev/xvdc"
      MountPath ="/data/elasticsearch"
    }
  ]
}
variable "livefeed_disk_paths" {
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
    },
    {
      Filesystem="/dev/xvdf"
      MountPath="/home/mettl/proctoring-data"
    }
  ]
}

variable "htmltopdf_disk_paths" {
  type="list"
  default=[
    {
      Filesystem="/dev/xvda1"
      MountPath="/"
    },
    {
      Filesystem="/dev/xvdb"
      MountPath="/home/mettl/mettl_logs"
    },
    {
      Filesystem="/dev/xvdc"
      MountPath ="/home/mettl/volume1"
    }
  ]
}

variable "intellisense_disk_paths" {
  type="list"
  default=[
    {
      Filesystem="/dev/xvda1"
      MountPath="/"
    },
    {
      Filesystem="/dev/xvdb"
      MountPath="/home/mettl/mettl_logs"
    },
    {
      Filesystem="/dev/xvdc"
      MountPath ="/home/mettl/volume1"
    }
  ]
}

variable "english_simulator_disk_paths" {
  type="list"
  default=[
    {
      Filesystem="/dev/xvda1"
      MountPath="/"
    },
    {
      Filesystem="/dev/xvdb"
      MountPath="/home/mettl/mettl_logs"
    },
    {
      Filesystem="/dev/xvdc"
      MountPath ="/home/mettl/volume1"
    }
  ]
}

variable "mongo_light_member_disk_paths" {
type="list"
default=[
{
Filesystem="/dev/xvda1"
MountPath="/"
},
{
Filesystem="/dev/xvdb"
MountPath="/home/mettl/mettl_logs"
},
{
Filesystem="/dev/xvdc"
MountPath="/home/mettl/volume1"
},
{
Filesystem="/dev/xvde"
MountPath="/data/mongo"
}
]
}

variable "mongo_heavy_member_disk_paths" {
type="list"
default=[
{
Filesystem="/dev/xvda1"
MountPath="/"
},
{
Filesystem="/dev/mapper/vgmongo-lvmongo"
MountPath="/data/mongo"
}
]
}

variable "mongo_heavy_arbiter_disk_paths" {
type="list"
default=[
{
Filesystem="/dev/xvda1"
MountPath="/"
},
{
Filesystem="/dev/xvdg"
MountPath="/data/mongo"
}
]
}

variable "labs_backend_disk_paths" {
  type="list"
  default=[
    {
      Filesystem="/dev/xvda1"
      MountPath="/"
    },
    {
      Filesystem="/dev/xvdb"
      MountPath="/home/mettl/mettl_logs"
    },
    {
      Filesystem="/dev/xvdh"
      MountPath="/labs/users"
    }
  ]
}

variable "additional_route53_entries" {type="list"}
variable "root_mx_record_list" {type="list"}
variable "root_txt_record_list" {type="list"}
variable "txt_record_map" {type="list"}

################################# extra lc ebs ##########################

variable "lc_ebs_livefeed" {type="map"}
variable "redis_cache_type" {}
variable "janus_stun_server_address" {}
variable "janus_stunserver_port" {}
variable "lc_ebs_r_simulators_cms" {type="map"}