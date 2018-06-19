module "pro_env" {
  source = "./../modules/env"
  enable_monitoring=0
    ####### general ################
  env="pro"

  ## used in userdata of autoscaling groups
  ansible_pub_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1PP3vCE4JUr1pXLfm/6p+jrXHOeRwzwYIZQmKh5fkRsFtpVtZtA37+tz1NhnBBlbo6nimVOiH2ZeGEayFMGc8qiZ94PHri2UnVxzxe5hoCCmrqB3jrH6gWXBgI+he3XUUxqO3lom5MfhdPi8kXlz9KELTiW/K61zZ8Az+A6DTu8Y0b9BYObyago7LVpgBcmm9PueLZ8Tndr4jyMf+OTh/1KY4OjzahRkr/48bJCY9DYnLoniJYyYX2ysV/sQaHHswfMV619R/CFMNDRkiFYlVe7h10TvrZj/6diaqS7Qa5j/YIlUMQPsSnxqF8LslBWENQW9KO5/j+BD5J0qV7KWR"
  jenkins_pub_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDB07tUPUUi+7d3uErSGQlqeKY7+t8sED/p4BY5CXX4t+8NFM19Pe/OvMOL3pNOyP5PvzQ1+U43nxzOwDclXZNBDoJq8Fu7+8DziDci/k86T+LMCOddc2rwgvJkq3wmMYmh6kULNI6VVdHO6X4k5PxXVGv0w3mtDPOK0r0OYpZ8yA3dKDkddNROIF2N9KjU8ziJSCheohZLRwEVYUbIjuxdgjJaAmoB9L0i42TZRj4BnTi547EhZVdLic6piwMXBhiaJTSkKd0Jh8/kqBgB61XlOg372qaiYNgb7XIbNyrp5sbhWdsXUEKOpDwA0KsBYoFuXvMSCPcn6DqMbrUriHuZ"
  key_name = "pro-key"
  public_key_path = "./aws_key.pub"
  aws_region = "ap-south-1"
  default_az = "ap-south-1a"
  additional_az="ap-south-1b"
  aws_app_ami = "ami-43257b2c"
  aws_maintenance_ami = "ami-f7237d98"
  ssl-bundle="./ssl-bundle"
  ssl-private-key="./ssl-private-key"
  ssl-public-key="./ssl-certificate"
  logs_bucket_name = "mettl-logs-pro"
  acm_certificate_arn = "arn:aws:acm:ap-south-1:146954345992:certificate/f0864524-f3dd-40ad-be68-d136d6ddade4"
  ############################### eips ################################333
  eips = {
  interview-socket="eipalloc-32e0ba1c"
    chat_socket="eipalloc-f1edb7df"
    streaming="eipalloc-8ae4bea4"
    mettl_prelogin="eipalloc-8fe1bba1"
    offline_app="eipalloc-ea6742c4"
//    mettl_api="ami-43257b2c"
    jump_box="eipalloc-5b654075"
    openvpn="eipalloc-bfe2b891"
    client-api="eipalloc-0ceeb422"
    nat="eipalloc-a7edb789"
    status-mettl="eipalloc-58654076"
    labs-api="eipalloc-59654077"
  }

  ######## windows ########

  windows_codeproject_instance_user="Voldemort"
  windows_codelysis_instance_user="Voldemort"
  windows_codeproject_instance_password="preeti1234"
  windows_codelysis_instance_password="preeti1234"
  vpc_name = "vpc"
  vpc_cidr = "10.10.0.0/16"
  application_subnet_cidr = "10.10.1.0/24"
  additional_application_subnet_cidr = "10.10.2.0/24"
  maintenance_subnet_cidr = "10.10.3.0/24"
  additional_maintenance_subnet_cidr = "10.10.4.0/24"
  public_subnet_cidr = "10.10.5.0/24"
  additional_public_subnet_cidr = "10.10.6.0/24"
  ucl_subnet_cidr="10.10.7.0/24"
  private_dns_zone_name = "propvt"
  public_dns_zone_name = "mettl.pro"
  openvpn_instance_type="t2.small"
  elk_instance_type = "t2.medium"
  kafka_instance_type = "t2.small"
  zabbix_instance_type = "t2.small"
  jenkins-ansible_instance_type="t2.small"
  openvpn_instance_type="t2.small"
  mongodb_heavy_member1_instance_type = "t2.small"
  r_simulators_router_instance_type = "t2.small"
  mongodb_heavy_member2_instance_type = "t2.small"
  mongodb_heavy_arbiter_instance_type = "t2.small"
  mongodb_light_member1_instance_type = "t2.small"
  mongodb_light_member2_instance_type = "t2.small"
  mongodb_light_arbiter_instance_type = "t2.small"
  intellisense_csharp_instance_type = "t2.small"
  intellisense_instance_type = "t2.small"
  intellisense_java_instance_type = "t2.small"
  intellisense_python_instance_type = "t2.small"
  intellisense_router_instance_type = "t2.small"
  activemq_instance_type = "t2.small"
  nfs_instance_type="m4.large"
  redis_instance_type="t2.small"
  skillmaster_instance_type = "t2.small"
  skillmaster_general_instance_type = "t2.small"
  skillmaster_special_instance_type = "t2.small"
  skillmaster_admin_instance_type = "t2.small"
  chat_activemq_instance_type = "t2.small"
  fhgfs_ucl_code_project_instance_type = "t2.small"
  interviewApp_admin_frontend_instance_type = "t2.small"
  interviewApp_admin_backend_instance_type = "t2.small"
  interviewApp_candidate_frontend_instance_type = "t2.small"
  interviewApp_candidate_backend_instance_type = "t2.small"
  interviewApp_socket_instance_type = "t2.small"
  status_mettl_instance_type = "t2.small"
  master_1_elasticsearch_instance_type = "t2.small"
  master_2_elasticsearch_instance_type = "t2.small"
  master_3_elasticsearch_instance_type = "t2.small"
  data_1_elasticsearch_instance_type = "t2.small"
  data_2_elasticsearch_instance_type = "t2.small"
  question_service_instance_type = "t2.small"
  question_event_service_instance_type = "t2.small"
  corporate_instance_type="t2.small"
  duo_lingo_instance_type = "t2.small"
  notification_instance_type = "t2.small"
  threesixtyfeedback_instance_type = "t2.small"
  adminpanel_instance_type = "t2.small"
  prelogin_instance_type = "t2.small"
  certification_instance_type = "t2.small"
  api_instance_type = "t2.small"
  contest_instance_type="t2.small"
  api_demo_instance_type="t2.small"
  lms_instance_type="t2.small"
  igt_instance_type = "t2.small"
  hpe_instance_type = "t2.small"
  accenture_instance_type="t2.small"
  streaming_instance_type ="t2.small"
  chat_socket_instance_type="t2.small"
  chat_service_instance_type="t2.small"
  shared_report_corporate_instance_type="t2.small"
  offline_app_instance_type = "t2.small"
  windows_codeproject_instance_type = "t2.small"
  windows_codelysis_instance_type = "t2.small"
  pr_instance_type = "t2.small"
  uber_instance_type = "t2.small"
  chat_web_socket_instance_type = "t2.small"
  test_notification_instance_type = "t2.small"
  application_metrics_instance_type = "t2.medium"
  feedback_instance_type = "t2.small"
  fes_instance_type ="t2.small"
  bulkpdf_instance_type= "t2.small"
  dblysis_instance_type= "t2.small"
  typingsimulator_instance_type= "t2.small"
  report_instance_type= "t2.small"
  htmltopdf_instance_type = "t2.small"
  intellisense_instance_type = "t2.small"
  english_simulator_instance_type= "m3.medium"
  excel_instance_type="t2.small"
  large_excel_instance_type="t2.small"
  scheduler_instance_type="t2.small"
  schema_instance_type ="t2.small"
  live_feed_router_instance_type = "t2.small"
  proctoring_instance_type="t2.small"
  client_api_instance_type = "t2.small"
  static_instance_type = "t2.small"
  grader_instance_type="t2.small"
  labs_1_backend_instance_type = "t2.small"
  redis_cache_type = "cache.t2.small"
  labs_instance_type = "t2.small"
  labs_2_backend_instance_type = "t2.small"
  janus_stun_server_address = "stun.l.google.com"
  janus_stunserver_port = "19302"

  livefeed_stun_server_address = "173.194.71.127"
  livefeed_stunserver_port = "19302"
  livefeed_turn_url = "52.76.96.71"
  livefeed_turnURLPort = "3478"
#  lc_ebs_livefeed = {volume_type="gp2",volume_size=100}
  ######## Autoscaling #############
  aui = {

    lc_ami = "ami-4121042e"
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

    lc_ami = "ami-412c092e"
    lc_instance_type = "t2.small"
    as_max_size = "10"
    as_min_size = "1"
    # as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
  }

  proctoring-ui = {

    lc_ami = "ami-912f0afe"
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
    lc_ami = "ami-2a2a0f45"
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
    lc_ami = "ami-f2bfe19d"
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
    lc_ami = "ami-a83d18c7"
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
  ucl-codelysis={
    lc_ami = "ami-5f193c30"
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
    lc_ami = "ami-301c395f"
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
    lc_ami = "ami-ff1a3f90"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
  }

  java-codelysis={
    lc_ami = "ami-3c280d53"
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

    lc_ami = "ami-dd2702b2"
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

  master_2_elasticsearch_instance_type = "t2.small"
  data_2_elasticsearch_instance_type = "t2.medium"
  master_1_elasticsearch_instance_type = "t2.small"
  data_1_elasticsearch_instance_type = "t2.medium"
  master_3_elasticsearch_instance_type = "t2.small"

  application-grader =  {

    lc_ami = "ami-642b0e0b"
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
    lc_ami = "ami-16220779"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "2"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "ELB"

  }

  janus_live_feed_service = {
    lc_ami = "ami-16260379"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
  }

  windows_codeproject_instance_ebs_optimized = "false"
  report_corporate_instance_type = "t2.small"

  report-ui = {

    lc_ami = "ami-4c290c23"

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
    lc_ami = "ami-36220759"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "2"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "ELB"

  }


  mettl-api-gateway = {
    lc_ami = "ami-792d0816"
    lc_instance_type = "t2.micro"
    as_max_size = "10"
    as_min_size = "2"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "ELB"

  }

  email-service = {

    lc_ami = "ami-0420056b"
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

  r-simulator-spi={
    lc_ami = "ami-dc613bb3"
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

    lc_ami = "ami-966238f9"
    lc_instance_type = "t2.small"
    as_max_size = "1"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "EC2"
  }

  r-simulator-cms={
    lc_ami = "ami-b26948dd"
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
  lc_ebs_r_simulators_cms = {volume_type="gp2",volume_size=100}
  aws_mongodb_light_member1_ami = "ami-cb702ea4"
  aws_mongodb_light_member2_ami = "ami-cb702ea4"
  aws_windows_codelysis_ami = "ami-4f732d20"
  aws_mongodb_light_arbiter_ami = "ami-46702e29"
  wordpress_instance_type = "t2.small"
  aws_mongodb_heavy_member2_ami = "ami-98712ff7"
  aws_mongodb_heavy_arbiter_ami = "ami-9a702ef5"
  aws_mongodb_heavy_member1_ami = "ami-98712ff7"
  aws_windows_codeproject_ami = "ami-f7732d98"

  aws_intellisense_ami = "ami-145b237b"
  wordpress_ami = "ami-865d25e9"
  aws_fhgfs_ami = "ami-f05f279f"
  aws_english_simulator_ami = "ami-af5c24c0"
  aws_htmltopdf_ami = "ami-8d5d25e2"


  ############### Volume snapshot for data services ######
  fes_snapshot_id = "snap-01b820765fcb6ad0d"
  static_snapshot_id="snap-01f1a43701e2b82d2"
  fhgfs_ucl_code_project_snapshot_id = "snap-0bf73fc9ca7cf2499"
  igt_snapshot_id="snap-08bd5b266cce7b8f4"
  ##########################

}
