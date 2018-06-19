module "co_in_env" {
  source = "./../modules/env"

  ####### general ################
  env="xyz" ## used in userdata of autoscaling groups
  ansible_pub_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3vLxSCWPzGbDpplFLcMW4NnvmVXJYar9tjnnumJEIqLNiPuGiuO7ZZYNwM5TYdoWxBwOeQT5gnDz5NcuScqSEv6+V4aXFVHrnkJGiyQwXpBngbhYf2t9W4O42+Vh9DaR7T0SVaGYk4i/wsVR4kPSiZCMyEb2jUr0bloYmfXr/1k2u7Xzw+Y6PJZm7BmDH4imXHQQIl0MEJECer3wzu90uhsyH9N7R5Yi5X0inMpN/qeC0rGqRRApGTgj983yts2lD19EQn32wHGQx2b67+KtPmmUzRo4n1WHLt/Gjo36TijEHvLSCziAWpn5hIb6I5gL6/tb77BOxITJZWEHe0Biz shanky@ip-192-168-0-100.us-east-2.compute.internal"
  jenkins_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8+JwVorhhFEFxFMDVlihSXS31z3evEJccadY2Nc9E4J6R8jO86WPCQHOon3THmEBeLEAjguwic+kwgndapOKX9s8aPyrYOyGU7Sj2qZ6XeJN98zp/VfJgfbOqUPEwvN10Pv8jTWzNGSsTkIH/6uPSHOI9Cwk0ypEIx/UdsNljQyrmUx8/mhfO5Fl0pJfH5LiYZuuhyoO4ydh5m7/NgX9GeBC3uE0CgTEN9/R2sFVFiIdOzDtI16wzArzBziH9KKhvwsFGaF++VDZ7XjrI21Q7QLBCHU9+b0MOAXz42+dK1INFWzeLiJEEQvCuhWJzTcfMBok37NQgKDD3Svv2LErl jenkins-xyz"

  key_name = "mettl-key-try"
  public_key_path = "./xyz.pub"
  aws_region = "eu-central-1"
  default_az = "eu-central-1a"
  additional_az="eu-central-1b"
  aws_app_ami = "ami-fa18c095"
  aws_maintenance_ami = "ami-f518c09a"
  aws_htmltopdf_ami="ami-bec673d1"
  aws_intellisense_ami="ami-d1af75be"
  aws_english_simulator_ami="ami-bdc673d2"
  aws_mongodb_heavy_member1_ami="ami-0b1ab164"
  aws_mongodb_heavy_member2_ami="ami-4f1ab120"
  aws_mongodb_heavy_arbiter_ami="ami-0519b26a"

  aws_mongodb_light_member1_ami="ami-0c1ab163"
  aws_mongodb_light_member2_ami="ami-9a05aef5"
  aws_windows_codelysis_ami="ami-2bc67344"
  aws_windows_codeproject_ami="ami-cce73fa3"
  aws_fhgfs_ami = "ami-37a07f58"
  wordpress_ami = "ami-fa18c095"

  ssl-bundle="./xyz-ssl-bundle"
  ssl-private-key="./xyz-ssl-private-key"
  ssl-public-key="./xyz-ssl-public-key"
  logs_bucket_name = "mettl-logs-xyz"

  ############################### eips ################################333

  eips = {

    mettl_prelogin="eipalloc-f17a2198"
    offline_app="eipalloc-f1792298"
//    mettl_api="eipalloc-ab7823c2"
//    biometric="eipalloc-fe792297"
//    biometric_admin="eipalloc-947922fd"
    streaming="eipalloc-f27a219b"
    chat_socket="eipalloc-897a21e0"
    proxy="eipalloc-f379229a"
    nat="eipalloc-f0792299"
    openvpn="eipalloc-a6eeb5cf"
    client-api="eipalloc-3629045f"
    jump_box="eipalloc-7b782312"
    status-mettl="eipalloc-3e3b3957"
    labs-api="eipalloc-9cc684f5"
    interview-socket="eipalloc-f8f6b8d6"
    jobvite="eipalloc-a65e6388"
    reporting_metabase = "eipalloc-5179737f"
    hackathon= "eipalloc-e5656fcb"
  }



  ######## windows ########

  windows_codeproject_instance_user="Voldemort"
  windows_codelysis_instance_user="Voldemort"
  windows_codeproject_instance_password="preeti1234"
  windows_codelysis_instance_password="preeti1234"

  ####### vpc ####################
  ## nat_ami="ami-e32a408c"                                     # vpc
  vpc_name = "vpc"
  vpc_cidr = "10.0.0.0/16"
  application_subnet_cidr = "10.0.1.0/24"
  additional_application_subnet_cidr = "10.0.2.0/24"

  maintenance_subnet_cidr = "10.0.3.0/24"
  additional_maintenance_subnet_cidr = "10.0.4.0/24"

  public_subnet_cidr = "10.0.5.0/24"
  additional_public_subnet_cidr = "10.0.6.0/24"
  ucl_subnet_cidr = "10.0.8.0/24"

  private_dns_zone_name = "xyzpvt"
  public_dns_zone_name = "mettl.xyz"

  ######## Maintenance instances ##############
//  queue_metrics_instance_type="t2.micro"
  openvpn_instance_type="t2.micro"
  elk_instance_type = "t2.medium"
  kafka_instance_type = "t2.small"
  zabbix_instance_type = "t2.micro"
  jenkins-ansible_instance_type="t2.small"
  openvpn_instance_type="t2.micro"
  ######## data service instances ##############
  mongodb_heavy_member1_instance_type = "t2.micro"
  mongodb_heavy_member2_instance_type = "t2.micro"
  mongodb_heavy_arbiter_instance_type = "t2.micro"

  mongodb_light_member1_instance_type = "t2.micro"
  mongodb_light_member2_instance_type = "t2.micro"
  intellisense_csharp_instance_type = "t2.micro"
  intellisense_instance_type = "t2.micro"
  intellisense_java_instance_type = "t2.micro"
  intellisense_python_instance_type = "t2.micro"
  intellisense_router_instance_type = "t2.micro"
  activemq_instance_type = "t2.micro"
  nfs_instance_type="m4.large"
  redis_instance_type="t2.micro"
  skillmaster_instance_type = "t2.micro"
  skillmaster_general_instance_type = "t2.micro"
  skillmaster_special_instance_type = "t2.micro"
  skillmaster_admin_instance_type = "t2.micro"
  chat_activemq_instance_type = "t2.micro"
  fhgfs_ucl_code_project_instance_type = "t2.micro"
  interviewApp_admin_frontend_instance_type = "t2.micro"
  interviewApp_admin_backend_instance_type = "t2.micro"
  interviewApp_candidate_frontend_instance_type = "t2.micro"
  interviewApp_candidate_backend_instance_type = "t2.micro"
  interviewApp_socket_instance_type = "t2.micro"
  status_mettl_instance_type = "t2.micro"
  master_1_elasticsearch_instance_type = "t2.micro"
  master_2_elasticsearch_instance_type = "t2.micro"
  master_3_elasticsearch_instance_type = "t2.micro"
  data_1_elasticsearch_instance_type = "t2.micro"
  data_2_elasticsearch_instance_type = "t2.micro"
  question_event_service_instance_type = "t2.micro"
  reporting_metabase_instance_type = "t2.small"
  reporting_migrator_instance_type = "m4.large"
  reporting_metabase_count = "1"
  reporting_migrator_count = "1"
  redshift_count = "1"
  hackathon_instance_type = "t2.micro"


  ############# Tomcat instances ###############
  corporate_instance_type="t2.micro"
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
  uber_instance_type = "t2.micro"
  chat_web_socket_instance_type = "t2.micro"
  test_notification_instance_type = "t2.micro"
  application_metrics_instance_type = "t2.medium"
  lc_ebs_r_simulators_cms = {
    volume_type = "gp2",
    volume_size = 100
  }
  r_simulators_router_instance_type = "t2.small"
  feedback_instance_type = "t2.micro"
  ############## Java Service Instanes #########
  fes_instance_type ="t2.micro"
  bulkpdf_instance_type= "t2.micro"
  dblysis_instance_type= "t2.micro"
  typingsimulator_instance_type= "t2.micro"
  report_instance_type= "t2.micro"
  htmltopdf_instance_type = "t2.micro"
  client_archival_instance_type = "t2.medium"
  mongo_client_archival_instance_type ="t2.medium"
  intellisense_instance_type = "t2.micro"
  english_simulator_instance_type= "m3.medium"
  excel_instance_type="t2.micro"
  large_excel_instance_type="t2.micro"
  scheduler_instance_type="t2.micro"
  schema_instance_type ="t2.micro"
  live_feed_router_instance_type = "t2.micro"
  proctoring_instance_type="t2.micro"
  client_api_instance_type = "t2.micro"
  ############## Other instances #############
  static_instance_type = "t2.micro"
  grader_instance_type="t2.micro"
  ############### Volume snapshot for data services ######
  fes_snapshot_id = "snap-0e855a89feaf96820"
  static_snapshot_id="snap-0796116b6e301a5bd"
  fhgfs_ucl_code_project_snapshot_id = "snap-0315b07a9665ce12c"
  igt_snapshot_id = "snap-04eddcd4973f6a37e"

  ######## Wordpress #######
  wordpress_instance_type="t2.micro"
  ######## Autoscaling #############
  aui = {

    lc_ami = "ami-8a2e1a61"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "2"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "EC2"
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

    lc_ami = "ami-ed587d06"
    lc_instance_type = "t2.small"
    as_max_size = "10"
    as_min_size = "1"
    # as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
  }

  proctoring-ui = {

    lc_ami = "ami-9d557076"
    lc_instance_type = "t2.micro"
    as_max_size = "2"
    as_min_size = "1"
    # as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
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

  scheduler-candidate-event = {
    lc_ami = "ami-ae240145"
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
    lc_ami = "ami-312f935e"
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

  ucl-code-project={
    lc_ami = "ami-ea5b7e01"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "1"
    # as_desired_size = "0"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    elb_idle_timeout="240"
    set_connection_draining=true
    connection_draining_timeout="300"
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

  blue-green = {
    lc_ami = "ami-fa18c095"
    lc_instance_type = "t2.micro"
    as_max_size = "0"
    as_min_size = "0"
    # as_desired_size = "2"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    elb_idle_timeout = "600"
    set_connection_draining = true
    connection_draining_timeout = "100"
    scale_up_consecutive_periods = "1"
    scale_up_period = "60"
    cpu_high_threshold = "90"
    scale_down_consecutive_periods = "5"
    scale_down_period = "60"
    cpu_low_threshold = "50"
    scale_down_by_instances = "-1"
    scale_up_by_instances = "1"
    scale_up_warmup = "100"
  }
  ucl-codelysis={
    lc_ami = "ami-165a7ffd"
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
    lc_ami = "ami-e85f7a03"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "1"
    #  as_desired_size = "0"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    elb_idle_timeout="180"
    set_connection_draining=true
    connection_draining_timeout="300"
  }


  live_feed_service={
    lc_ami = "ami-901b3e7b"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
  }

  java-codelysis={
    lc_ami = "ami-ba5b7e51"
    lc_instance_type = "t2.medium"
    as_max_size = "10"
    as_min_size = "1"
    # as_desired_size = "0"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    elb_idle_timeout="1200"
    set_connection_draining=true
    connection_draining_timeout="300"

  }
  proxy = {

    lc_ami = "ami-4b5e7ba0"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "1"
    # as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
  }
  root_mx_record_list = []
  txt_record_map = []
  enable_monitoring = 0
  lc_ebs_livefeed = {volume_type="gp2",volume_size=100}
  livefeed_stun_server_address = "173.194.71.127"
  livefeed_stunserver_port = "19302"
  livefeed_turn_url = "52.76.96.71"
  livefeed_turnURLPort = "3478"
  skill_master_data_bucket_name = "skill-master-data-backup-info"
  additional_route53_entries = []
  metric_publishing_instance_type = "m4.large"
  root_txt_record_list = []

  master_2_elasticsearch_instance_type = "t2.micro"
  data_2_elasticsearch_instance_type = "t2.micro"
  master_1_elasticsearch_instance_type = "t2.micro"
  data_1_elasticsearch_instance_type = "t2.micro"
  master_3_elasticsearch_instance_type = "t2.micro"

application-grader =  {

  lc_ami = "ami-f2577219"
  lc_instance_type = "t2.medium"
  as_max_size = "10"
  as_min_size = "1"
  #  as_desired_size = "1"
  as_default_cooldown = "60"
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
    lc_ami = "ami-6c517487"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "2"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "ELB"

  }

  janus_live_feed_service = {
    lc_ami = "ami-3abe9cd1"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
  }

  windows_codeproject_instance_ebs_optimized = "false"
  report_corporate_instance_type = "t2.micro"

  report-ui = {

    lc_ami = "ami-c9547122"

    lc_instance_type = "t2.micro"
    as_max_size = "5"
    as_min_size = "1"
    # as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
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


  mettl-api = {
    lc_ami = "ami-d0b0863b"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "2"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "ELB"

  }


  mettl-api-gateway = {
    lc_ami = "ami-59b086b2"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "2"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "ELB"

  }

  email-service = {

    lc_ami = "ami-385471d3"
    lc_instance_type = "t2.small"
    as_max_size = "5"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "60"
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

  labs_1_backend_instance_type = "t2.micro"
  redis_cache_type = "cache.t2.small"
  labs_instance_type = "t2.micro"
  labs_2_backend_instance_type = "t2.micro"
  janus_stun_server_address = "stun.l.google.com"
  janus_stunserver_port = "19302"
  question-service = {
    lc_ami = "ami-f44e6b1f"
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

  cos-api={
    lc_ami = "ami-df496c34"
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

  aws_mongodb_light_member3_ami = "ami-af4a1044"
  ucl-codelysis-revert = { lc_ami = "ami-107221fb"
lc_instance_type = "t2.micro"
as_max_size = "20"
as_min_size = "0"
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
scale_up_warmup="100"}

  r-simulator-spi={
    lc_ami = "ami-8b7d5160"
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

    lc_ami = "ami-e17a560a"
    lc_instance_type = "t2.small"
    as_max_size = "1"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "EC2"
  }

  yolo={
    lc_ami = "ami-449cabaf"
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

  r-simulator-cms={
    lc_ami = "ami-7a87b091"
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


  report-service-api ={
  lc_ami = "ami-6a4b6e81"
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
scale_up_warmup="100"}

  acm_certificate_arn = "arn:aws:acm:eu-central-1:760572120597:certificate/228f2cf2-ff77-4e35-9df3-57991bca24c6"
  mongodb_light_member3_instance_type = "t2.micro"
  jobvite_instance_type = "t2.micro"
  assessment-service =  {
    lc_ami = "ami-18496cf3"
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

  almdigital_instance_type = "t2.micro"
}
