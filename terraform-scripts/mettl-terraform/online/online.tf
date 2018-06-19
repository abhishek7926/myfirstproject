module "online_env" {
  source = "./../modules/env"
  enable_monitoring=0
  ####### general ################
  env="online"

  ## used in userdata of autoscaling groups
  ansible_pub_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5WqppACr/3oJR+DteRy3T/apu4192AZmKhkWYSlfaPyxgroS3axQh8mJkHXGJrIO2vv/ZwFtcBpFQX8igS2fKVecp/DvE8o5L/6DnM06fzDMPfyOFZMQM6vyBg3bz9sPlUmmcivXCHJFJWDYY3IKiBgONi1ejewpDQ/CuOUcPxCZeY6SqI5Mt5MPREkhASN9/wlNFFgBQ4YHED/JzC+16t0jv1mu040LztNxz4YtP/482dxUhZShT6W9R+y/ETo3jxTN7IaPIlCdSdlaPnI8BMx+ARS1qDiHuKcgiJJXmZJVztMYzMZSEZLW9lYYQ3lvHnpzPuyNsJ6XqjxLZ6fnH preeti@mettl299"
//  jenkins_pub_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrqMaWkl99OW6lVvQSF4CWBJCtf5qqxiyY0jrdhjr8Qp2DKIXwXqj0b5DdWCGG/Nn7GJYQQfbrkomJCmhjTQFX/nD+HTcis+q7pJg8tSp92HfgAekN2grsxGo9UD6yXtA+ehcRciWC74PA4wCf43VnZwRTtY/ad/x2K4mtJal9LnI/e9XgWRbnZGlrB4HKeGPVb4OVFcW8LHS+DmEBxNKI0Ddr+kpf4bjOR9aktYH2wp6zTLnO0ptLjLrnbogc1fcPxa/v8pEe3xMA0s1cTork4iUTFD4t4PRSklrtFlAYkOGNSLYJNO3lHlUSVNR+prZM8HZ3Kcd8vQ20Mp6sGXJb preeti@mettl299"

  key_name = "online-key"
  public_key_path = "./aws_key.pub"
  aws_region = "ap-south-1"
  default_az = "ap-south-1a"
  additional_az="ap-south-1b"
  aws_app_ami = "ami-bb7108d4"
  aws_maintenance_ami = "ami-7c710813"

  aws_htmltopdf_ami="ami-4b710824"
  aws_intellisense_ami="ami-4471082b"
  aws_english_simulator_ami="ami-47641d28"
  aws_mongodb_heavy_member1_ami="ami-ce0b73a1"
  aws_mongodb_heavy_member2_ami="ami-ce0b73a1"
  aws_mongodb_heavy_arbiter_ami="ami-4300782c"

  aws_mongodb_light_member1_ami="ami-cd0078a2"
  aws_mongodb_light_member2_ami="ami-cd0078a2"
  aws_mongodb_light_arbiter_ami="ami-4000782f"
  aws_windows_codelysis_ami="ami-4f700920"
  aws_windows_codeproject_ami="ami-137e077c"
  aws_fhgfs_ami = "ami-da1d62b5"
  wordpress_ami = "ami-2c7e0743"

  ssl-bundle="./ssl-bundle"
  ssl-private-key="./ssl-private-key"
  ssl-public-key="./ssl-certificate"
  logs_bucket_name = "mettl-logs-online"
  skill_master_data_bucket_name = "skill-master-data-backup-online"
  ############################### eips ################################333
  eips = {
    mettl_prelogin="eipalloc-2acb4843"
    offline_app="eipalloc-6cec6d05"
    mettl_api="eipalloc-c6ca49af"
    streaming="eipalloc-c0ec6da9"
    chat_socket="eipalloc-38c94a51"
    proxy="eipalloc-2dcb4844"
    jump_box="eipalloc-cacb48a3"
    openvpn="eipalloc-c7ca49ae"
    client-api="eipalloc-68ca4901"
    nat="eipalloc-67c7470e"
  }

  ######## windows ########

  windows_codeproject_instance_user="Voldemort"
  windows_codelysis_instance_user="Voldemort"
  windows_codeproject_instance_password="preeti1234"
  windows_codelysis_instance_password="preeti1234"

  ####### vpc ####################
  ## nat_ami="ami-e32a408c"                                     # vpc
  vpc_name = "vpc"
  vpc_cidr = "172.16.0.0/16"
  application_subnet_cidr = "172.16.1.0/24"
  additional_application_subnet_cidr = "172.16.2.0/24"

  maintenance_subnet_cidr = "172.16.3.0/24"
  additional_maintenance_subnet_cidr = "172.16.4.0/24"

  public_subnet_cidr = "172.16.5.0/24"
  additional_public_subnet_cidr = "172.16.6.0/24"

  ucl_subnet_cidr="172.16.7.0/24"

  private_dns_zone_name = "onlinepvt"
  public_dns_zone_name = "mettl.online"

  ######## Maintenance instances ##############
  openvpn_instance_type="t2.micro"
  elk_instance_type = "t2.medium"
  kafka_instance_type = "t2.small"
  zabbix_instance_type = "t2.micro"
  jenkins-ansible_instance_type="m4.large"
  openvpn_instance_type="t2.micro"
  metric_publishing_instance_type="m4.2xlarge"
  ######## data service instances ##############
  mongodb_heavy_member1_instance_type = "r3.large"
  mongodb_heavy_member2_instance_type = "r3.large"
  mongodb_heavy_arbiter_instance_type = "t2.medium"

  mongodb_light_member1_instance_type = "t2.medium"
  mongodb_light_member2_instance_type = "t2.medium"
  mongodb_light_arbiter_instance_type = "t2.micro"

  activemq_instance_type = "t2.medium"
  nfs_instance_type="m4.large"
  redis_instance_type="m4.large"
  skillmaster_instance_type = "t2.micro"
  skillmaster_general_instance_type = "c4.xlarge"
  skillmaster_special_instance_type = "c4.xlarge"
  skillmaster_admin_instance_type = "c4.xlarge"
  question_service_instance_type = "t2.medium"
  question_event_service_instance_type = "t2.micro"

  chat_activemq_instance_type = "t2.medium"
  fhgfs_ucl_code_project_instance_type = "r3.large"



//  ############# Intellisense instances ##########
//  intellisense_router_instance_type = "t2.nano"
//  intellisense_csharp_instance_type = "t2.nano"
//  intellisense_java_instance_type = "t2.micro"
//  intellisense_python_instance_type = "t2.nano"

  ############# Tomcat instances ###############

  uber_instance_type = "t2.micro"
  chat_web_socket_instance_type = "t2.medium"
  application_metrics_instance_type = "t2.micro"
  test_notification_instance_type = "t2.micro"
  feedback_instance_type = "t2.micro"
  corporate_instance_type="m4.xlarge"
  duo_lingo_instance_type = "t2.micro"
  notification_instance_type = "t2.medium"
  threesixtyfeedback_instance_type = "t2.micro"
  adminpanel_instance_type = "c4.2xlarge"
  prelogin_instance_type = "t2.medium"
  certification_instance_type = "m4.large"
  api_instance_type = "r3.large"
  contest_instance_type="r3.large"
  api_demo_instance_type="t2.micro"
  lms_instance_type="m4.xlarge"
  igt_instance_type = "t2.medium"
  hpe_instance_type = "t2.medium"
  accenture_instance_type="t2.micro"
  streaming_instance_type ="m4.xlarge"
  chat_socket_instance_type="c4.xlarge"
  chat_service_instance_type="t2.medium"
  shared_report_corporate_instance_type="r3.large"
  offline_app_instance_type = "t2.micro"
  windows_codeproject_instance_type = "c4.4xlarge"
  windows_codelysis_instance_type = "t2.medium"
  pr_instance_type = "t2.medium"
  ############## Java Service Instanes #########
  fes_instance_type ="m4.large"
  bulkpdf_instance_type= "t2.medium"
  dblysis_instance_type= "t2.medium"
  typingsimulator_instance_type= "t2.micro"
  report_instance_type= "t2.medium"
  htmltopdf_instance_type = "t2.micro"
  intellisense_instance_type = "t2.micro"
  english_simulator_instance_type= "t2.micro"
  excel_instance_type="m4.xlarge"
  large_excel_instance_type="m4.xlarge"
  scheduler_instance_type="m4.large"
  schema_instance_type ="t2.medium"
  live_feed_router_instance_type = "t2.small"
  proctoring_instance_type="t2.medium"
  client_api_instance_type = "t2.micro"
  master_1_elasticsearch_instance_type = "t2.medium"
  master_2_elasticsearch_instance_type = "t2.medium"
  master_3_elasticsearch_instance_type = "t2.medium"
  data_1_elasticsearch_instance_type = "t2.medium"
  data_2_elasticsearch_instance_type = "t2.medium"

  ############## Other instances #############
  static_instance_type = "t2.micro"
  grader_instance_type="c4.large"
  ######## Wordpress #######
  wordpress_instance_type="t2.medium"
  ##########################
  ############### Volume snapshot for data services ######
  fes_snapshot_id = "snap-01ef4107011e6410f"
  static_snapshot_id="snap-0676d0430b21214ee"
  skill_master_snapshot_id="snap-021da60674cb16c19"
  skill_master_admin_snapshot_id="snap-0d25af8e563818963"
  skill_master_general_snapshot_id="snap-021da60674cb16c19"
  skill_master_special_snapshot_id="snap-0f981757ddadd9e14"
  fhgfs_ucl_code_project_snapshot_id = "snap-0dee4f407ea3438c1"
  igt_snapshot_id="snap-0e70453853121a8b2"
  ##########################
  livefeed_stun_server_address = "52.77.142.113"
  livefeed_stunserver_port = "3478"
  livefeed_turn_url = "52.77.142.113"
  livefeed_turnURLPort = "3478"
  lc_ebs_livefeed = {volume_type="gp2",volume_size=100}


  ######## Autoscaling #############
  aui = {
    lc_ami = "ami-03344c6c"
    lc_instance_type = "c4.2xlarge"
    user_data_file_name = "../aui-userdata"
    as_max_size = "10"
    as_min_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "100"
    health_check_type = "ELB"
    scale_up_consecutive_periods="1"
    scale_up_period="300"
    cpu_high_threshold="90"
    scale_down_consecutive_periods="2"
    scale_down_period="300"
    cpu_low_threshold="50"
    scale_down_by_instances="-1"
    scale_up_by_instances="1"
    scale_up_warmup="100"
    health_check_response_timeout = "9"
    health_check_interval = "11"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
  }

  coding-simulator = {

    lc_ami = "ami-c3364eac"
    lc_instance_type = "t2.small"
    user_data_file_name = "../codingsimulator-userdata"
    as_max_size = "10"
    as_min_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "100"
    health_check_type = "ELB"
    health_check_response_timeout = "5"
    health_check_interval = "29"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
  }


  scheduler-candidate-event = {
    lc_ami = "ami-c5374faa"
    lc_instance_type = "t2.micro"
    user_data_file_name = "../scheduler-userdata"
    as_max_size = "20"
    as_min_size = "1"
    as_default_cooldown = "60"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    queue="candidateEvent"

    low_queue_size_threshold="10"
    scale_down_period="60"
    scale_down_consecutive_periods="15"
    scale_down_by_instances="-1"
    scale_down_cooldown="300"

    high_queue_size_threshold="250"
    scale_up_period="60"
    scale_up_consecutive_periods="5"
    scale_up_by_instances="1"
    scale_up_cooldown="300"
  }

  mip={
    lc_ami = "ami-b3671edc"
    lc_instance_type = "t2.small"
    user_data_file_name = "../mip-userdata"
    as_max_size = "70"
    as_min_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "EC2"

    queue="proctoring"
    low_queue_size_threshold="5"
    scale_down_period="60"
    scale_down_consecutive_periods="15"
    scale_down_by_instances="-1"
    scale_down_cooldown="900"

    high_queue_size_threshold="100"
    scale_up_period="60"
    scale_up_consecutive_periods="5"
    scale_up_by_instances="1"
    scale_up_cooldown="900"
  }

  ucl-code-project={
    lc_ami = "ami-6f354d00"
    lc_instance_type = "c4.2xlarge"
    user_data_file_name = "../ucl-code-project-userdata"
    as_max_size = "20"
    as_min_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "100"
    health_check_type = "ELB"

    cpu_low_threshold="30"
    scale_down_period="60"
    scale_down_consecutive_periods="5"
    scale_down_by_instances="-1"

    cpu_high_threshold="60"
    scale_up_period="60"
    scale_up_consecutive_periods="2"
    scale_up_by_instances="1"
    scale_up_warmup="180"

    health_check_response_timeout = "9"
    health_check_interval = "10"
    elb_idle_timeout="240"
    set_connection_draining=true
    connection_draining_timeout="300"
    elb_logs_interval ="5"
    elb_logs_enabled ="true"
  }

  ucl-codelysis={
    lc_ami = "ami-c0364eaf"
    lc_instance_type = "c4.large"
    user_data_file_name = "../ucl-codelysis-userdata"
    as_max_size = "20"
    as_min_size = "1"
    # as_desired_size = "2"
    as_default_cooldown = "300"
    health_check_grace_period = "100"
    health_check_type = "ELB"
    health_check_response_timeout = "9"
    health_check_interval = "10"
    elb_idle_timeout="600"
    set_connection_draining=true
    connection_draining_timeout="100"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
    scale_up_consecutive_periods="1"
    scale_up_period="60"
    cpu_high_threshold="50"
    scale_down_consecutive_periods="5"
    scale_down_period="60"
    cpu_low_threshold="20"
    scale_down_by_instances="-1"
    scale_up_by_instances="2"
    scale_up_warmup="100"
  }
  ucl-codelysis-android={
    lc_ami = "ami-2c354d43"
    lc_instance_type = "c4.2xlarge"
    user_data_file_name = "../ucl-codelysis-android-userdata"
    as_max_size = "1"
    as_min_size = "1"
    #  as_desired_size = "0"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    health_check_response_timeout = "9"
    health_check_interval = "10"
    elb_idle_timeout="180"
    set_connection_draining=true
    connection_draining_timeout="300"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
    disk_evaluation_period=1
    disk_period=60
    disk_high_threshold=80
  }


  live_feed_service={
    lc_ami = "ami-8e2159e1"
    lc_instance_type = "c4.xlarge"
    user_data_file_name = "../livefeed-service-userdata"
    as_max_size = "2"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
  }

  java-codelysis={
    lc_ami = "ami-b82850d7"
    lc_instance_type = "t2.medium"
    user_data_file_name = "../java-codelysis-userdata"
    as_max_size = "5"
    as_min_size = "1"
    # as_desired_size = "0"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    health_check_response_timeout = "4"
    health_check_interval = "5"
    elb_idle_timeout="1200"
    set_connection_draining=true
    connection_draining_timeout="300"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
  }

  proxy = {

    lc_ami = "ami-4a364e25"
    lc_instance_type = "t2.micro"
    user_data_file_name = "../proxy-userdata"
    as_max_size = "10"
    as_min_size = "1"
    # as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    health_check_response_timeout = "2"
    health_check_interval = "5"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
  }

  ##### route53 ####

  root_mx_record_list = []
  txt_record_map = []
  additional_route53_entries = []
  root_txt_record_list = []
  intellisense_java_instance_type = "t2.micro"
  intellisense_csharp_instance_type = "t2.micro"
  intellisense_python_instance_type = "t2.micro"
  intellisense_router_instance_type = "t2.micro"
  jenkins_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrqMaWkl99OW6lVvQSF4CWBJCtf5qqxiyY0jrdhjr8Qp2DKIXwXqj0b5DdWCGG/Nn7GJYQQfbrkomJCmhjTQFX/nD+HTcis+q7pJg8tSp92HfgAekN2grsxGo9UD6yXtA+ehcRciWC74PA4wCf43VnZwRTtY/ad/x2K4mtJal9LnI/e9XgWRbnZGlrB4HKeGPVb4OVFcW8LHS+DmEBxNKI0Ddr+kpf4bjOR9aktYH2wp6zTLnO0ptLjLrnbogc1fcPxa/v8pEe3xMA0s1cTork4iUTFD4t4PRSklrtFlAYkOGNSLYJNO3lHlUSVNR+prZM8HZ3Kcd8vQ20Mp6sGXJb jenkins-online"
}
