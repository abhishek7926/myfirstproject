module "info_env" {
  source = "./../modules/env"
  enable_monitoring=0
    ####### general ################
  env="info"
//  web_urls_to_monitor =[
//  #  {
//   #   name="https://mettl.com"
//   #   response_code="301"
//
//    #}
//  ]

  ## used in userdata of autoscaling groups
  ansible_pub_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCc3Hb2IHQ+3hgY47BdZJr/afO9dAkyGILB3BBBtvstRdcs3JUtfvCP3gf4zt25mZVKa4h8Ns2fr7xb/sQyCA7yU+fcijTNyu4buQ/jgeOxFZ8fO3NClXcQIAcKGkGWhNCL/E4t7Vy2UcQ9GdfPIul4Kq2SmmpmQvRV6ZS5CMLjhS3+AYI3/TwBdM3q5zhdObIGBNQt4EG2kdwek+k2sK6WRMLnpYXsGlvZnsrrn98bM8+uwfaGnRDerb4+babVeIQzGInrRbOUnikSGwsX2Yfu7+PRqI5Chw48WXURTXmlNkzr4RD5L1tDOR4/MC+xAd9RioeWmystVvDCLxgynBTH shanky@shankys-MacBook-Pro.local"
  jenkins_pub_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+SZ8WdSDDJL3h07FaSxkLZmvNVYJ37FH6V2Gv9kry2pnIKrZsJYh4eacrT8yOW1PY1ibIZF3lolayWl3GLGceY8E61fzG0tcwV2sZP5XJFsBx8d574oUstREdtstNTCa9hy6jTeXKj34FIxjlSTFjm/jAXxHMa6XdQIUaAcYsv53mHirwFZkBia23s42BTVzRysyroaTmBzKqz0VZaRJaoRgy9z93X2DLMJQtO2rcP84k3F/k3cFMY7xU7haT1AsfRynkjd7fjUcBjKI0yXa0iR9ao3XMWNkJJ0r0cJpQYBNQ2/jDt9aGPHn47SKUqjr4WRbvscxA+2KkZpA1njAj shanky@shankys-MacBook-Pro.local"
  key_name = "info-key"
  public_key_path = "./info.pub"
  aws_region = "ap-south-1"
  default_az = "ap-south-1a"
  additional_az="ap-south-1b"
  aws_app_ami = "ami-dc1d62b3"
  aws_maintenance_ami = "ami-fa1b6495"
  aws_htmltopdf_ami="ami-8d5d25e2"
  aws_intellisense_ami="ami-ae1e61c1"
  aws_english_simulator_ami="ami-10433c7f"
  aws_mongodb_heavy_member1_ami="ami-d9f68eb6"
  aws_mongodb_heavy_member2_ami="ami-e4f48c8b"
  aws_mongodb_heavy_arbiter_ami="ami-ebf38b84"

  aws_mongodb_light_member1_ami="ami-83f38bec"
  aws_mongodb_light_member2_ami="ami-b9f58dd6"
  aws_mongodb_light_member3_ami="ami-ad7a25c2"
  aws_windows_codelysis_ami="ami-681b6407"
  aws_windows_codeproject_ami="ami-933c77fc"
  aws_fhgfs_ami = "ami-da1d62b5"
  wordpress_ami = "ami-dc1d62b3"

  ssl-bundle="./info-ssl-bundle"
  ssl-private-key="./info-ssl-private-key"
  ssl-public-key="./info-ssl-public-key"
  logs_bucket_name = "mettl-logs-info"
  skill_master_data_bucket_name = "skill-master-data-backup-info"
  acm_certificate_arn = "arn:aws:acm:ap-south-1:760572120597:certificate/fe438473-765f-4417-a349-4a9a6134217a"
  ############################### eips ################################333
  eips = {
    interview-socket="eipalloc-7c9fbb52"
    mettl_prelogin="eipalloc-52c57f3b"
    offline_app="eipalloc-88c47ee1"
    mettl_api="eipalloc-22ec6d4b"
    reporting_metabase="eipalloc-52c0ff7c"
//    biometric="eipalloc-94ea6bfd"
//    biometric_admin="eipalloc-52ea6b3b"
    streaming="eipalloc-65ef6e0c"
    chat_socket="eipalloc-6aec6d03"
    proxy="eipalloc-c0ec6da9"
    jump_box="eipalloc-b3c77dda"
    openvpn="eipalloc-6bec6d02"
    client-api="eipalloc-55ea6b3c"
    nat="eipalloc-d575f9bc"
    status-mettl="eipalloc-9dea9cb3"
    labs-api="eipalloc-6eeaa240"
    jobvite="eipalloc-5fedba71"
    almdigital="eipalloc-f40650da"
    hackathon= "eipalloc-c7ca49ae"
  }

  ######## windows ########

  windows_codeproject_instance_user="Voldemort"
  windows_codelysis_instance_user="Voldemort"
  windows_codeproject_instance_password="preeti1234"
  windows_codelysis_instance_password="preeti1234"

  ####### vpc ####################
  ## nat_ami="ami-e32a408c"                                     # vpc
  vpc_name = "vpc"
  vpc_cidr = "172.17.0.0/16"
  application_subnet_cidr = "172.17.1.0/24"
  additional_application_subnet_cidr = "172.17.2.0/24"

  maintenance_subnet_cidr = "172.17.3.0/24"
  additional_maintenance_subnet_cidr = "172.17.4.0/24"

  public_subnet_cidr = "172.17.5.0/24"
  additional_public_subnet_cidr = "172.17.6.0/24"

  ucl_subnet_cidr="172.17.7.0/24"

  private_dns_zone_name = "infopvt"
  public_dns_zone_name = "mettl.info"

  ######## Maintenance instances ##############
  openvpn_instance_type="t2.micro"
  elk_instance_type = "t2.medium"
  kafka_instance_type = "t2.small"
  zabbix_instance_type = "t2.micro"
  jenkins-ansible_instance_type="t2.small"
  openvpn_instance_type="t2.micro"
  metric_publishing_instance_type="m4.large"
  ######## data service instances ##############
  master_1_elasticsearch_instance_type = "t2.micro"
  master_2_elasticsearch_instance_type = "t2.micro"
  master_3_elasticsearch_instance_type = "t2.micro"
  data_1_elasticsearch_instance_type = "t2.micro"
  data_2_elasticsearch_instance_type = "t2.micro"
  mongodb_heavy_member1_instance_type = "t2.micro"
  mongodb_heavy_member2_instance_type = "t2.micro"
  mongodb_heavy_arbiter_instance_type = "t2.micro"
  lc_ebs_r_simulators_cms = {volume_type="gp2",volume_size=100}
  r_simulators_router_instance_type = "t2.small"
  reporting_metabase_instance_type = "t2.small"
  reporting_migrator_instance_type = "m4.large"
  mongodb_light_member1_instance_type = "t2.micro"
  mongodb_light_member2_instance_type = "t2.micro"
  mongodb_light_member3_instance_type = "t2.micro"
  activemq_instance_type = "t2.micro"
  nfs_instance_type="m4.large"
  redis_instance_type="t2.micro"
  redis_cache_type="cache.t2.small"
  skillmaster_instance_type = "t2.micro"
  skillmaster_general_instance_type = "t2.micro"
  skillmaster_special_instance_type = "t2.micro"
  skillmaster_admin_instance_type = "t2.micro"
  chat_activemq_instance_type = "t2.micro"
  fhgfs_ucl_code_project_instance_type = "t2.micro"
  redshift_count = "0"
  reporting_metabase_count = "1"
  reporting_migrator_count = "1"
  ############# Tomcat instances ###############
  corporate_instance_type="t2.micro"
  report_corporate_instance_type="t2.micro"
  duo_lingo_instance_type = "t2.micro"
  notification_instance_type = "t2.micro"
  threesixtyfeedback_instance_type = "t2.micro"
  adminpanel_instance_type = "t2.micro"
  prelogin_instance_type = "t2.micro"
  certification_instance_type = "t2.micro"
  api_instance_type = "t2.micro"
  contest_instance_type="t2.micro"
//  biometric_admin_instance_type="t2.micro"
//  biometric_instance_type="t2.micro"
  api_demo_instance_type="t2.micro"
  lms_instance_type="t2.micro"
  igt_instance_type = "t2.micro"
  hpe_instance_type = "t2.micro"
  accenture_instance_type="t2.micro"
//  dubaiway_instance_type="t2.micro"
//  practice_test_instance_type = "t2.micro"
  streaming_instance_type ="t2.micro"
  chat_socket_instance_type="t2.micro"
  chat_service_instance_type="t2.micro"
//  ndlm_info_instance_type="t2.micro"
  shared_report_corporate_instance_type="t2.micro"
  offline_app_instance_type = "t2.micro"
  windows_codeproject_instance_type = "t2.micro"
  windows_codelysis_instance_type = "t2.micro"
  pr_instance_type = "t2.micro"
  ############## Java Service Instanes #########
  fes_instance_type ="t2.micro"
  bulkpdf_instance_type= "t2.micro"
  dblysis_instance_type= "t2.micro"
  typingsimulator_instance_type= "t2.micro"
  report_instance_type= "t2.micro"
  htmltopdf_instance_type = "t2.micro"
  intellisense_instance_type = "t2.micro"
  english_simulator_instance_type= "t2.micro"
  excel_instance_type="t2.micro"
  large_excel_instance_type="t2.micro"
  scheduler_instance_type="t2.micro"
  schema_instance_type ="t2.micro"
  live_feed_router_instance_type = "t2.micro"
  proctoring_instance_type="t2.micro"
  client_api_instance_type = "t2.micro"
  chat_web_socket_instance_type = "t2.micro"
  application_metrics_instance_type = "t2.micro"
  test_notification_instance_type = "t2.micro"
  uber_instance_type = "t2.micro"
  feedback_instance_type = "t2.micro"
  jobvite_instance_type = "t2.micro"
  almdigital_instance_type = "t2.micro"
  client_archival_instance_type = "t2.micro"
  mongo_client_archival_instance_type ="t2.micro"
  hackathon_instance_type = "t2.micro"

  ############## Other instances #############
  static_instance_type = "t2.small"
  grader_instance_type="t2.micro"
  ############# Intellisense instances ##########
    intellisense_router_instance_type = "t2.nano"
    intellisense_csharp_instance_type = "t2.nano"
    intellisense_java_instance_type = "t2.micro"
    intellisense_python_instance_type = "t2.nano"
  ############### Volume snapshot for data services ######
  fes_snapshot_id = "snap-0cc7708b7bfe6b1df"
  static_snapshot_id="snap-096c3696b87174226"
  fhgfs_ucl_code_project_snapshot_id = "snap-0250d4e3cda1ffaef"
  igt_snapshot_id="snap-07bca3b8346dabd4f"
  ######## Wordpress #######
  wordpress_instance_type="t2.micro"

  ##########################
livefeed_stun_server_address = "173.194.71.127"
livefeed_stunserver_port = "19302"
livefeed_turn_url = "52.76.96.71"
livefeed_turnURLPort = "3478"
lc_ebs_livefeed = {volume_type="gp2",volume_size=100}

  ######## Autoscaling #############
  aui = {
    lc_ami = "ami-d7ba93b8"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "2"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    health_check_response_timeout = "9"
    health_check_interval = "10"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
    scale_up_consecutive_periods="1"
    scale_up_period="300"
    cpu_high_threshold="90"
    scale_down_consecutive_periods="2"
    scale_down_period="300"
    cpu_low_threshold="50"
    scale_down_by_instances="-1"
    scale_up_by_instances="1"
    scale_up_warmup="100"
      }

  coding-simulator = {

    lc_ami = "ami-5b80da34"
    lc_instance_type = "t2.small"
    as_max_size = "10"
    as_min_size = "1"
    # as_desired_size = "1"
    as_default_cooldown = "300"
        health_check_grace_period = "300"
    health_check_type = "EC2"
    health_check_response_timeout = "5"
    health_check_interval = "29"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
      }

  scheduler-candidate-event = {
    lc_ami = "ami-3782d858"
    lc_instance_type = "t2.nano"
    as_max_size = "10"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "60"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    low_queue_size_threshold="10"
    scale_down_by_instances="-1"
    high_queue_size_threshold="250"
    scale_up_period="60"
    scale_down_period="60"
    scale_up_by_instances="1"
    queue="candidateEvent"
    scale_down_consecutive_periods="15"
    scale_up_consecutive_periods="5"
    scale_up_cooldown="300"
    scale_down_cooldown="300"
      }

  mip={
    lc_ami = "ami-bc0343d3"
    lc_instance_type = "t2.nano"
    as_max_size = "10"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    queue="proctoring"
    low_queue_size_threshold="5"
    scale_down_by_instances="-1"
    scale_down_period="60"
    scale_down_consecutive_periods="15"
    high_queue_size_threshold="100"
    scale_up_consecutive_periods="5"
    scale_up_by_instances="1"
    scale_up_period="60"
    scale_up_cooldown="900"
    scale_down_cooldown="900"
  }

  yolo={
    lc_ami = "ami-f378539c"
    lc_instance_type = "t2.micro"
    as_max_size = "1"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    queue="proctoring_java"
    low_queue_size_threshold="5"
    scale_down_by_instances="-1"
    scale_down_period="60"
    scale_down_consecutive_periods="15"
    high_queue_size_threshold="100"
    scale_up_consecutive_periods="5"
    scale_up_by_instances="1"
    scale_up_period="60"
    scale_up_cooldown="900"
    scale_down_cooldown="900"
      }

  ucl-code-project={
    lc_ami = "ami-5c81db33"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "1"
    # as_desired_size = "0"
    as_default_cooldown = "300"
        health_check_grace_period = "300"
    health_check_type = "EC2"
    health_check_response_timeout = "9"
    health_check_interval = "10"
    elb_idle_timeout="240"
    set_connection_draining=true
    connection_draining_timeout="300"
    elb_logs_interval ="5"
    elb_logs_enabled ="true"
    scale_up_consecutive_periods="2"
    scale_up_period="60"
    cpu_high_threshold="60"
    scale_down_consecutive_periods="5"
    scale_down_period="60"
    cpu_low_threshold="30"
    scale_down_by_instances="-1"
    scale_up_by_instances="1"
    scale_up_warmup="180"
      }
  ucl-codelysis={
    lc_ami = "ami-988aa2f7"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "1"
    # as_desired_size = "2"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "EC2"
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
    scale_up_by_instances="3"
    scale_up_warmup="100"
      }
ucl-codelysis-revert={
   lc_ami = "ami-a683c7c9"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "1"
    # as_desired_size = "2"
    as_default_cooldown = "300"
        health_check_grace_period = "300"
    health_check_type = "EC2"
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
    lc_ami = "ami-1b80da74"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "1"
    #  as_desired_size = "0"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
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
    lc_ami = "ami-e37e5b8c"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    health_check_response_timeout = "9"
    health_check_interval = "10"
}

  java-codelysis={
    lc_ami = "ami-6a8dd705"
    lc_instance_type = "t2.medium"
    as_max_size = "10"
    as_min_size = "1"
    # as_desired_size = "0"
    as_default_cooldown = "300"
        health_check_grace_period = "300"
    health_check_type = "EC2"
    health_check_response_timeout = "4"
    health_check_interval = "5"
    elb_idle_timeout="1200"
    set_connection_draining=true
    connection_draining_timeout="300"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
      }
  proxy = {

    lc_ami = "ami-a983d9c6"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "1"
    # as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
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


  interviewApp_socket_instance_type="t2.micro"
  interviewApp_candidate_frontend_instance_type = "t2.nano"
  interviewApp_admin_backend_instance_type = "t2.nano"
  question_event_service_instance_type = "t2.micro"
  interviewApp_admin_frontend_instance_type = "t2.nano"
  interviewApp_candidate_backend_instance_type = "t2.nano"
  proctoring-ui = {


    lc_ami = "ami-ce80daa1"
    lc_instance_type = "t2.micro"
    as_max_size = "2"
    as_min_size = "1"
    # as_desired_size = "1"
    as_default_cooldown = "300"
        health_check_grace_period = "300"
    health_check_type = "ELB"
    health_check_response_timeout = "5"
    health_check_interval = "29"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
    scale_up_consecutive_periods="1"
    scale_up_period="600"
    cpu_high_threshold="50"
    scale_down_consecutive_periods="2"
    scale_down_period="600"
    cpu_low_threshold="20"
    scale_down_by_instances="-1"
    scale_up_by_instances="1"
    scale_up_warmup="100"

  }
  status_mettl_instance_type = "t2.nano"



  application-grader = {
    lc_ami = "ami-358dd75a"
    lc_instance_type = "t2.medium"
    as_max_size = "10"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    low_queue_size_threshold="10"
    scale_down_by_instances="-1"
    high_queue_size_threshold="50"
    scale_up_period="60"
    scale_down_period="60"
    scale_up_by_instances="1"
    queue="applicationGrader"
    scale_down_consecutive_periods="1"
    scale_up_consecutive_periods="1"
    scale_up_cooldown="300"
    scale_down_cooldown="300"


  }

    pr = {
     lc_ami = "ami-6082d80f"
     lc_instance_type = "t2.micro"
     as_max_size = "10"
     as_min_size = "2"
     #  as_desired_size = "1"
     as_default_cooldown = "300"
     health_check_grace_period = "300"
     health_check_type = "ELB"
     health_check_response_timeout = "9"
     health_check_interval = "10"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"

 }

  mettl-api = {
    lc_ami = "ami-3fbf9650"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "2"
    #  as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    health_check_response_timeout = "9"
    health_check_interval = "10"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"

  }
  windows_codeproject_instance_ebs_optimized = "false"

  mettl-api-gateway = {
    lc_ami = "ami-9fbc95f0"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "2"
    #  as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    health_check_response_timeout = "9"
    health_check_interval = "10"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"

  }

  report-ui = {

    lc_ami = "ami-8087ddef"

  lc_instance_type = "t2.micro"
    as_max_size = "5"
    as_min_size = "1"
    # as_desired_size = "1"
    as_default_cooldown = "300"
        health_check_grace_period = "300"
    health_check_type = "ELB"
    health_check_response_timeout = "5"
    health_check_interval = "29"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
    scale_up_consecutive_periods="1"
    scale_up_period="300"
    cpu_high_threshold="80"
    scale_down_consecutive_periods="2"
    scale_down_period="300"
    cpu_low_threshold="50"
    scale_down_by_instances="-1"
    scale_up_by_instances="1"
    scale_up_warmup="100"
  }

  janus_live_feed_service = {
    lc_ami = "ami-df2104b0"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    health_check_response_timeout = "9"
    health_check_interval = "10"
  }




  labs_1_backend_instance_type = "t2.micro"
  email-service = {

    lc_ami = "ami-178dd778"
    lc_instance_type = "t2.small"
    as_max_size = "5"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    low_queue_size_threshold="5"
    scale_down_by_instances="-1"
    high_queue_size_threshold="50"
    scale_up_period="60"
    scale_down_period="60"
    scale_up_by_instances="1"
    queue="email"
    scale_down_consecutive_periods="15"
    scale_up_consecutive_periods="5"
    scale_up_cooldown="300"
    scale_down_cooldown="300"




  }
  labs_2_backend_instance_type = "t2.micro"
  labs_instance_type = "t2.micro"
  report-service-api={
    lc_ami = "ami-a083d9cf"
    lc_instance_type = "t2.micro"
    user_data_file_name = "./../report-service-api-userdata"
    as_max_size = "10"
    as_min_size = "2"
    # as_desired_size = "0"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    health_check_response_timeout = "4"
    health_check_interval = "5"
    elb_idle_timeout="600"
    set_connection_draining=true
    connection_draining_timeout="300"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
    scale_up_consecutive_periods="1"
    scale_up_period="300"
    cpu_high_threshold="90"
    scale_down_consecutive_periods="2"
    scale_down_period="300"
    cpu_low_threshold="50"
    scale_down_by_instances="-1"
    scale_up_by_instances="1"
    scale_up_warmup="100"
  }
  assessment-service = {
    lc_ami = "ami-bb8fd5d4"
    lc_instance_type = "t2.micro"
    user_data_file_name = "./../assessment-service-api-userdata"
    as_max_size = "10"
    as_min_size = "2"
    # as_desired_size = "0"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    health_check_response_timeout = "4"
    health_check_interval = "5"
    elb_idle_timeout="600"
    set_connection_draining=true
    connection_draining_timeout="300"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
    scale_up_consecutive_periods="1"
    scale_up_period="300"
    cpu_high_threshold="90"
    scale_down_consecutive_periods="2"
    scale_down_period="300"
    cpu_low_threshold="50"
    scale_down_by_instances="-1"
    scale_up_by_instances="1"
    scale_up_warmup="100"

  }
  janus_stun_server_address = "stun.l.google.com"
  janus_stunserver_port = "19302"

  cos-api={
    lc_ami = "ami-edbb9d82"
    lc_instance_type = "t2.small"
    user_data_file_name = "./../cos-api-userdata"
    as_max_size = "10"
    as_min_size = "2"
    # as_desired_size = "0"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    health_check_response_timeout = "4"
    health_check_interval = "5"
    elb_idle_timeout="600"
    set_connection_draining=true
    connection_draining_timeout="300"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
    scale_up_consecutive_periods="1"
    scale_up_period="300"
    cpu_high_threshold="90"
    scale_down_consecutive_periods="2"
    scale_down_period="300"
    cpu_low_threshold="50"
    scale_down_by_instances="-1"
    scale_up_by_instances="1"
    scale_up_warmup="100"
  }

  r-simulator-spi={
    lc_ami = "ami-74e9c81b"
    lc_instance_type = "t2.micro"
    as_max_size = "1"
    as_min_size = "1"
    # as_desired_size = "2"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    elb_idle_timeout="600"
    set_connection_draining=true
    connection_draining_timeout="100"

  }

  r-socket = {

    lc_ami = "ami-a3ebcacc"
    lc_instance_type = "t2.small"
    as_max_size = "1"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "EC2"
  }

  r-simulator-cms={
    lc_ami = "ami-d6e0cdb9"
    lc_instance_type = "c4.large"
    as_max_size = "2"
    as_min_size = "2"
    # as_desired_size = "2"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    elb_idle_timeout="600"
    set_connection_draining=true
    connection_draining_timeout="100"

  }

question-service = {
lc_ami = "ami-3082d85f"
lc_instance_type = "t2.micro"
as_max_size = "10"
as_min_size = "2"
# as_desired_size = "2"
as_default_cooldown = "300"
health_check_grace_period = "300"
health_check_type = "ELB"
elb_idle_timeout="600"
set_connection_draining=true
connection_draining_timeout="100"
scale_up_consecutive_periods="1"
scale_up_period="60"
cpu_high_threshold="90"
scale_down_consecutive_periods="5"
scale_down_period="60"
cpu_low_threshold="50"
scale_down_by_instances="-1"
scale_up_by_instances="1"
scale_up_warmup="100"}

  blue-green = {
    lc_ami = "ami-3082d85f"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "1"
    # as_desired_size = "2"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    elb_idle_timeout="600"
    set_connection_draining=true
    connection_draining_timeout="100"
    scale_up_consecutive_periods="1"
    scale_up_period="60"
    cpu_high_threshold="90"
    scale_down_consecutive_periods="5"
    scale_down_period="60"
    cpu_low_threshold="50"
    scale_down_by_instances="-1"
    scale_up_by_instances="1"
    scale_up_warmup="100"}

  plagiarism={
    lc_ami = "ami-1abc9375"
    lc_instance_type = "t2.medium"
    as_max_size = "2"
    as_min_size = "1"
    # as_desired_size = "0"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    health_check_response_timeout = "4"
    health_check_interval = "5"
    elb_idle_timeout="600"
    set_connection_draining=true
    connection_draining_timeout="300"
    elb_logs_interval ="60"
    elb_logs_enabled ="true"
    scale_up_consecutive_periods="1"
    scale_up_period="300"
    cpu_high_threshold="90"
    scale_down_consecutive_periods="2"
    scale_down_period="300"
    cpu_low_threshold="50"
    scale_down_by_instances="-1"
    scale_up_by_instances="1"
    scale_up_warmup="100"
  }
}

