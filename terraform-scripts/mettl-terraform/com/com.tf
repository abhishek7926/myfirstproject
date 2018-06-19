module "com_env" {
  source = "./../modules/env"
  enable_monitoring = 1
  ####### general ################
  env = "com"

  ## used in userdata of autoscaling groups
  ansible_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2oeK6dgy/EgZMnwQRC3Iaz4i3P3rzO6dt7Mgrm/U1rhD+jd6fwT/HKgMZ2r5f1rUUVVzmPQ9CAb9MScisCW6aJiVdCcF00Iz4H39Psvky7z1DfTwsufKfqJsX8mOVAo0Fq2yHqKWdY6M1L2aiUP2bA5odMEGS4kMTnruqvTM3ktDrWi0Cu2qc427SvW0oEB+a9J8GmB0eZ5SfwE4xSXe7sMwovB7ytGyUMjHvm1jwpQ4UR2HgiywrUBtmNeZntouPlBwzQ6lkvrdWsGvk2I2up9LsshnCxYCFWqhUa/8RVu2hkTnEeFRwm0LPNjSXYu6kYTGDo1tU+i4GLYG7T9Lj ansible-com@mettl"
  jenkins_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAFmHmYaVy+DGMJ7PE2x6SsnUry5BGWpI6vcab27DaZpZf6QibU+DW0hV/VOS1kNIO7Tg+NYh+/KU8agshnKdj5gij7D+RvnbPGcx3QCB0I220IS/uuoKT7dU9o0LGEKC/cEHfKbXV4TbgQoqh8odylFp+6yzQsnA+MFp31nYHEX37+KNHNxeXa/6UzrWDZMqsk81Ye8z41rz+kRnmhHMmt3H/1bKa5bAyNRzHw0Rkf3SAFFMQ+9a2iI2Q7BpxvJ6EEVBBuCeDNyFebErJBUz6ky8mbwgi4S8lQx9l42PSmHD8+pN4490/2RR6SQ/qgjU+tdaDy6s/euZeU6epMrx1 jenkins-com@mettl"
  key_name = "com-key"
  public_key_path = "./aws_key.pub"
  aws_region = "ap-south-1"
  default_az = "ap-south-1a"
  additional_az = "ap-south-1b"
  aws_app_ami = "ami-f6750d99"
  aws_maintenance_ami = "ami-1a720a75"

  aws_htmltopdf_ami = "ami-8d5d25e2"
  aws_intellisense_ami = "ami-145b237b"
  aws_english_simulator_ami = "ami-af5c24c0"
  aws_mongodb_heavy_member1_ami = "ami-df5e26b0"
  aws_mongodb_heavy_member2_ami = "ami-df5e26b0"
  aws_mongodb_heavy_arbiter_ami = "ami-a85921c7"

  aws_mongodb_light_member1_ami = "ami-f55d259a"
  aws_mongodb_light_member2_ami = "ami-f55d259a"
  aws_mongodb_light_member3_ami = "ami-f6321799"
  aws_windows_codelysis_ami = "ami-dc5e26b3"
  aws_windows_codeproject_ami = "ami-1b5a2274"
  aws_fhgfs_ami = "ami-f05f279f"
  wordpress_ami = "ami-865d25e9"

  ssl-bundle = "./ssl-bundle"
  ssl-private-key = "./ssl-private-key"
  ssl-public-key = "./ssl-certificate"
  logs_bucket_name = "mettl-logs-com"
  skill_master_data_bucket_name = "skill-master-data-backup-com"
  acm_certificate_arn = "arn:aws:acm:ap-south-1:760572120597:certificate/f89c5d04-75f1-4059-a21d-c86982188b13"
  ############################### eips ################################333
  eips = {
    interview-socket = "eipalloc-155f073b"
    chat_socket = "eipalloc-70c77d19"
    streaming = "eipalloc-b2c77ddb"
    mettl_prelogin = "eipalloc-97cb48fe"
    offline_app = "eipalloc-6dc94a04"
    //    mettl_api="eipalloc-2dcb4844"
    jump_box = "eipalloc-28ed6c41"
    openvpn = "eipalloc-95ea6bfc"
    client-api = "eipalloc-31ca4958"
    nat = "eipalloc-69ca4900"
    status-mettl = "eipalloc-18a2d436"
    labs-api = "eipalloc-041b582a"
    jobvite = "eipalloc-1dc5e933"
    reporting_metabase = "eipalloc-29695407"
    hackathon= "eipalloc-6b635a45"

  ######## windows ########

  windows_codeproject_instance_user = "Voldemort"
  windows_codelysis_instance_user = "Voldemort"
  windows_codeproject_instance_password = "preeti1234"
  windows_codelysis_instance_password = "preeti1234"

  ####### vpc ####################
  ## nat_ami="ami-e32a408c"                                     # vpc
  vpc_name = "vpc"
  vpc_cidr = "20.0.0.0/16"
  application_subnet_cidr = "20.0.1.0/24"
  additional_application_subnet_cidr = "20.0.2.0/24"

  maintenance_subnet_cidr = "20.0.3.0/24"
  additional_maintenance_subnet_cidr = "20.0.4.0/24"

  public_subnet_cidr = "20.0.5.0/24"
  additional_public_subnet_cidr = "20.0.6.0/24"

  ucl_subnet_cidr = "20.0.7.0/24"

  private_dns_zone_name = "compvt"
  public_dns_zone_name = "mettl.com"

  ######## Maintenance instances ##############
  openvpn_instance_type = "t2.micro"
  elk_instance_type = "t2.medium"
  kafka_instance_type = "t2.small"
  zabbix_instance_type = "t2.micro"
  jenkins-ansible_instance_type = "m4.large"
  openvpn_instance_type = "t2.micro"
  metric_publishing_instance_type = "m4.2xlarge"
  ######## data service instances ##############
  mongodb_heavy_member1_instance_type = "r3.large"
  mongodb_heavy_member2_instance_type = "r3.large"
  mongodb_heavy_arbiter_instance_type = "t2.medium"

  mongodb_light_member1_instance_type = "m4.large"
  mongodb_light_member2_instance_type = "m4.large"
  mongodb_light_member3_instance_type = "m4.large"

  activemq_instance_type = "t2.medium"
  nfs_instance_type = "m4.large"
  redis_instance_type = "m4.large"
  skillmaster_instance_type = "t2.micro"
  skillmaster_general_instance_type = "c4.xlarge"
  skillmaster_special_instance_type = "c4.xlarge"
  skillmaster_admin_instance_type = "c4.xlarge"
  question_event_service_instance_type = "t2.micro"
  chat_activemq_instance_type = "t2.medium"
  fhgfs_ucl_code_project_instance_type = "r3.large"
  reporting_metabase_instance_type = "t2.small"
  reporting_migrator_instance_type = "m4.large"
  reporting_metabase_count = "1"
  reporting_migrator_count = "1"
  redshift_count = "1"
  hackathon_instance_type = "t2.medium"

  ############# Tomcat instances ###############
  uber_instance_type = "t2.micro"
  chat_web_socket_instance_type = "t2.medium"
  application_metrics_instance_type = "t2.micro"
  test_notification_instance_type = "t2.micro"
  lc_ebs_r_simulators_cms = {
    volume_type = "gp2",
    volume_size = 100
  }
  r_simulators_router_instance_type = "t2.small"
  feedback_instance_type = "t2.micro"
  corporate_instance_type = "m4.xlarge"
  duo_lingo_instance_type = "t2.micro"
  notification_instance_type = "t2.medium"
  threesixtyfeedback_instance_type = "t2.micro"
  adminpanel_instance_type = "c4.2xlarge"
  prelogin_instance_type = "t2.medium"
  certification_instance_type = "m4.xlarge"
  api_instance_type = "r3.large"
  contest_instance_type = "r3.large"
  api_demo_instance_type = "t2.micro"
  lms_instance_type = "m4.xlarge"
  igt_instance_type = "t2.medium"
  hpe_instance_type = "t2.medium"
  accenture_instance_type = "t2.micro"
  streaming_instance_type = "m4.xlarge"
  chat_socket_instance_type = "c4.xlarge"
  chat_service_instance_type = "t2.medium"
  shared_report_corporate_instance_type = "r3.large"
  offline_app_instance_type = "t2.micro"
  windows_codeproject_instance_type = "c4.large"
  windows_codelysis_instance_type = "c4.large"
  pr_instance_type = "t2.medium"
  ############## Java Service Instanes #########
  fes_instance_type = "m4.large"
  bulkpdf_instance_type = "t2.medium"
  dblysis_instance_type = "t2.medium"
  typingsimulator_instance_type = "t2.micro"
  report_instance_type = "t2.medium"
  htmltopdf_instance_type = "t2.medium"
  intellisense_instance_type = "t2.micro"
  english_simulator_instance_type = "t2.micro"
  excel_instance_type = "m4.xlarge"
  large_excel_instance_type = "m4.xlarge"
  scheduler_instance_type = "m4.large"
  schema_instance_type = "t2.medium"
  live_feed_router_instance_type = "t2.small"
  proctoring_instance_type = "t2.medium"
  client_api_instance_type = "t2.micro"
  master_1_elasticsearch_instance_type = "t2.medium"
  master_2_elasticsearch_instance_type = "t2.medium"
  master_3_elasticsearch_instance_type = "t2.medium"
  data_1_elasticsearch_instance_type = "t2.medium"
  data_2_elasticsearch_instance_type = "t2.medium"
  client_archival_instance_type = "t2.medium"
  mongo_client_archival_instance_type ="t2.medium"
  ############## Other instances #############
  static_instance_type = "t2.micro"
  grader_instance_type = "c4.large"
  ######## Wordpress #######
  wordpress_instance_type = "t2.medium"
  ##########################
  ############# Intellisense instances ##########
  intellisense_router_instance_type = "t2.nano"
  intellisense_csharp_instance_type = "t2.nano"
  intellisense_java_instance_type = "m4.xlarge"
  intellisense_python_instance_type = "t2.nano"
  ############### Volume snapshot for data services ######
  fes_snapshot_id = "snap-0f1835649c85c6993"
  static_snapshot_id = "snap-02d94a9847783d944"
  fhgfs_ucl_code_project_snapshot_id = "snap-0b6b9b249f9129795"
  igt_snapshot_id = "snap-03cb2ac7ec7c1d6fc"
  ##########################
  livefeed_stun_server_address = "52.77.142.113"
  livefeed_stunserver_port = "3478"
  livefeed_turn_url = "52.77.142.113"
  livefeed_turnURLPort = "3478"
  lc_ebs_livefeed = {
    volume_type = "gp2",
    volume_size = 100
  }


  ######## Autoscaling #############
  aui = {
    lc_ami = "ami-33cae35c"
    lc_instance_type = "c4.2xlarge"
    user_data_file_name = "../aui-userdata"
    as_max_size = "10"
    as_min_size = "2"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    scale_up_consecutive_periods = "1"
    scale_up_period = "300"
    cpu_high_threshold = "90"
    scale_down_consecutive_periods = "2"
    scale_down_period = "300"
    cpu_low_threshold = "50"
    scale_down_by_instances = "-1"
    scale_up_by_instances = "1"
    scale_up_warmup = "100"
  }

  coding-simulator = {

    lc_ami = "ami-39a3ee56"
    lc_instance_type = "t2.small"
    user_data_file_name = "../codingsimulator-userdata"
    as_max_size = "10"
    as_min_size = "2"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
  }


  scheduler-candidate-event = {
    lc_ami = "ami-5985c336"
    lc_instance_type = "t2.micro"
    user_data_file_name = "../scheduler-userdata"
    as_max_size = "20"
    as_min_size = "1"
    as_default_cooldown = "60"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    queue = "candidateEvent"

    low_queue_size_threshold = "10"
    scale_down_period = "60"
    scale_down_consecutive_periods = "50"
    scale_down_by_instances = "-1"
    scale_down_cooldown = "600"

    high_queue_size_threshold = "250"
    scale_up_period = "60"
    scale_up_consecutive_periods = "5"
    scale_up_by_instances = "1"
    scale_up_cooldown = "120"
  }

  mip = {
    lc_ami = "ami-844606eb"
    lc_instance_type = "t2.small"
    user_data_file_name = "../mip-userdata"
    as_max_size = "70"
    as_min_size = "4"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "EC2"

    queue = "proctoring"
    low_queue_size_threshold = "5"
    scale_down_period = "60"
    scale_down_consecutive_periods = "50"
    scale_down_by_instances = "-1"
    scale_down_cooldown = "300"

    high_queue_size_threshold = "100"
    scale_up_period = "60"
    scale_up_consecutive_periods = "5"
    scale_up_by_instances = "2"
    scale_up_cooldown = "120"
  }

  ucl-code-project = {
    lc_ami = "ami-cc83c5a3"
    lc_instance_type = "c4.2xlarge"
    user_data_file_name = "../ucl-code-project-userdata"
    as_max_size = "20"
    as_min_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"

    cpu_low_threshold = "30"
    scale_down_period = "60"
    scale_down_consecutive_periods = "5"
    scale_down_by_instances = "-1"

    cpu_high_threshold = "60"
    scale_up_period = "60"
    scale_up_consecutive_periods = "2"
    scale_up_by_instances = "1"
    scale_up_warmup = "180"

    elb_idle_timeout = "240"
    set_connection_draining = true
    connection_draining_timeout = "300"
  }

  ucl-codelysis = {
    lc_ami = "ami-9bb493f4"
    lc_instance_type = "c4.large"
    user_data_file_name = "../ucl-codelysis-userdata"
    as_max_size = "50"
    as_min_size = "5"
    # as_desired_size = "2"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    elb_idle_timeout = "600"
    set_connection_draining = true
    connection_draining_timeout = "100"
    scale_up_consecutive_periods = "1"
    scale_up_period = "60"
    cpu_high_threshold = "50"
    scale_down_consecutive_periods = "5"
    scale_down_period = "60"
    cpu_low_threshold = "20"
    scale_down_by_instances = "-1"
    scale_up_by_instances = "3"
    scale_up_warmup = "100"
  }
  ucl-codelysis-android = {
    lc_ami = "ami-ee83c581"
    lc_instance_type = "c4.2xlarge"
    user_data_file_name = "../ucl-codelysis-android-userdata"
    as_max_size = "1"
    as_min_size = "1"
    #  as_desired_size = "0"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    elb_idle_timeout = "180"
    set_connection_draining = true
    connection_draining_timeout = "300"
    disk_evaluation_period = 1
    disk_period = 60
    disk_high_threshold = 80
  }


  live_feed_service = {
    lc_ami = "ami-ca83c5a5"
    lc_instance_type = "c4.xlarge"
    user_data_file_name = "../livefeed-service-userdata"
    as_max_size = "2"
    as_min_size = "2"
    #  as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
  }

    yolo={
      lc_ami = "ami-7b0c2514"
      lc_instance_type = "p2.xlarge"
      as_max_size = "8"
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

  java-codelysis = {
    lc_ami = "ami-2387c14c"
    lc_instance_type = "t2.medium"
    user_data_file_name = "../java-codelysis-userdata"
    as_max_size = "5"
    as_min_size = "2"
    # as_desired_size = "0"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    elb_idle_timeout = "1200"
    set_connection_draining = true
    connection_draining_timeout = "300"
  }

  proxy = {

    lc_ami = "ami-ad124fc2"
    lc_instance_type = "t2.micro"
    user_data_file_name = "../proxy-userdata"
    as_max_size = "10"
    as_min_size = "2"
    # as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
  }

  additional_route53_entries = [
    {
      name = "math",
      type = "A",
      ttl = "600",
      value = "54.251.156.249"
    },
    {
      name = "bugzilla",
      type = "A",
      ttl = "600",
      value = "203.122.36.102"
    },
    {
      name = "stg",
      type = "A",
      ttl = "600",
      value = "54.251.190.27"
    },
    {
      name = "admin.csc-gov",
      type = "A",
      ttl = "60",
      value = "13.126.65.157"
    },
    {
      name = "paytm",
      type = "A",
      ttl = "600",
      value = "52.43.31.87"
    },
    {
      name = "node",
      type = "A",
      ttl = "600",
      value = "52.77.125.32"
    },
    {
      name = "mettlheads",
      type = "A",
      ttl = "600",
      value = "166.62.27.179"
    },
    {
      name = "testgit",
      type = "A",
      ttl = "600",
      value = "52.74.233.155"
    },
    {
      name = "chef",
      type = "A",
      ttl = "600",
      value = "54.169.93.111"
    },
    {
      name = "zobbr",
      type = "A",
      ttl = "600",
      value = "52.77.159.119"
    },
    {
      name = "testlink",
      type = "A",
      ttl = "600",
      value = "52.74.243.118"
    },
    {
      name = "disha2",
      type = "A",
      ttl = "600",
      value = "52.66.122.217"
    },
    {
      name = "kibana",
      type = "A",
      ttl = "600",
      value = "54.251.163.181"
    },
    {
      name = "dockerhub",
      type = "A",
      ttl = "600",
      value = "52.74.48.168"
    },
    {
      name = "docs",
      type = "A",
      ttl = "600",
      value = "54.251.163.181"
    },
    {
      name = "vleapp",
      type = "A",
      ttl = "600",
      value = "52.74.242.129"
    },
    {
      name = "mpa-test",
      type = "A",
      ttl = "600",
      value = "54.169.59.13"
    },
    {
      name = "o7.em",
      type = "A",
      ttl = "600",
      value = "167.89.56.69"
    },
    {
      name = "mpa",
      type = "A",
      ttl = "600",
      value = "54.169.59.13"
    },
    {
      name = "wiproapi1",
      type = "A",
      ttl = "600",
      value = "52.74.199.41"
    },
    {
      name = "git",
      type = "A",
      ttl = "600",
      value = "54.251.190.27"
    },
    {
      name = "wipro",
      type = "A",
      ttl = "600",
      value = "54.169.74.11"
    },
    {
      name = "blog_temp",
      type = "A",
      ttl = "600",
      value = "54.251.150.250"
    },
    {
      name = "disha-cms",
      type = "A",
      ttl = "600",
      value = "52.66.122.217"
    },
    {
      name = "pong",
      type = "A",
      ttl = "600",
      value = "125.63.71.138"
    },
    {
      name = "csc-gov2",
      type = "A",
      ttl = "60",
      value = "35.154.179.208"
    },
    {
      name = "bugs",
      type = "A",
      ttl = "600",
      value = "52.74.136.222"
    },
    {
      name = "ndlminfo",
      type = "A",
      ttl = "600",
      value = "52.74.83.54"
    },
    {
      name = "practice",
      type = "A",
      ttl = "600",
      value = "35.154.196.174"
    },
    {
      name = "staging",
      type = "A",
      ttl = "600",
      value = "182.74.109.230"
    },
    {
      name = "nexus",
      type = "A",
      ttl = "600",
      value = "54.251.163.181"
    },
    {
      name = "o12.email",
      type = "A",
      ttl = "600",
      value = "167.89.28.224"
    },
    {
      name = "gerrit",
      type = "A",
      ttl = "600",
      value = "52.74.243.118"
    },
    {
      name = "location",
      type = "A",
      ttl = "600",
      value = "35.154.49.110"
    },
    {
      name = "turnserver",
      type = "A",
      ttl = "600",
      value = "52.77.142.113"
    },
    {
      name = "mat",
      type = "A",
      ttl = "600",
      value = "54.251.151.27"
    },
    {
      name = "dubaiway",
      type = "A",
      ttl = "600",
      value = "52.220.190.41"
    },
    {
      name = "panel",
      type = "A",
      ttl = "600",
      value = "184.168.221.4"
    },
    {
      name = "jpanel",
      type = "A",
      ttl = "600",
      value = "50.63.202.12"
    },
    {
      name = "mediaserver",
      type = "A",
      ttl = "600",
      value = "52.77.125.32"
    },
    {
      name = "corporate",
      type = "A",
      ttl = "600",
      value = "54.251.150.250"
    },
    {
      name = "mumbaivpn",
      type = "A",
      ttl = "600",
      value = "52.66.89.36"
    },
    {
      name = "englishsimulator",
      type = "A",
      ttl = "600",
      value = "203.122.36.102"
    },
    {
      name = "mumbai2",
      type = "A",
      ttl = "600",
      value = "52.66.96.84"
    },
    {
      name = "central-jenkins",
      type = "A",
      ttl = "600",
      value = "54.251.163.181"
    },
    {
      name = "csc-gov",
      type = "CNAME",
      ttl = "60",
      value = "pmgdisha-prod-676056152.ap-south-1.elb.amazonaws.com"
    },
    {
      name = "mail",
      type = "CNAME",
      ttl = "600",
      value = "pop.secureserver.net"
    },
    {
      name = "javathon2016",
      type = "CNAME",
      ttl = "600",
      value = "javathon2016.mettl.com.s3-website-ap-southeast-1.amazonaws.com"
    },
    {
      name = "s1._domainkey",
      type = "CNAME",
      ttl = "600",
      value = "s1.domainkey.u284005.wl.sendgrid.net"
    },
    {
      name = "videos",
      type = "CNAME",
      ttl = "600",
      value = "app.wistia.com"
    },
    {
      name = "click",
      type = "CNAME",
      ttl = "600",
      value = "go.transfersecure.net"
    },
    {
      name = "imap",
      type = "CNAME",
      ttl = "600",
      value = "imap.secureserver.net"
    },
    {
      name = "pop",
      type = "CNAME",
      ttl = "600",
      value = "pop.secureserver.net"
    },
    {
      name = "khguwigcbrno",
      type = "CNAME",
      ttl = "600",
      value = "gv-ebckrovuizz23v.dv.googlehosted.com"
    },
    {
      name = "webmail",
      type = "CNAME",
      ttl = "600",
      value = "webmail.secureserver.net"
    },
    {
      name = "leads",
      type = "CNAME",
      ttl = "600",
      value = "cloud.viewpage.co"
    },
    {
      name = "e",
      type = "CNAME",
      ttl = "600",
      value = "email.secureserver.net"
    },
    {
      name = "disha",
      type = "CNAME",
      ttl = "600",
      value = "pmgdisha-prod-676056152.ap-south-1.elb.amazonaws.com"
    },
    {
      name = "pages",
      type = "CNAME",
      ttl = "600",
      value = "3030863.group13.sites.hubspot.net"
    },
    {
      name = "mobilemail",
      type = "CNAME",
      ttl = "600",
      value = "mobilemail-v01.prod.mesa1.secureserver.net"
    },
    {
      name = "hwacvhxx6mix.pages",
      type = "CNAME",
      ttl = "600",
      value = "gv-zeqy4putot3thq.dv.googlehosted.com"
    },
    {
      name = "gjsci",
      type = "CNAME",
      ttl = "600",
      value = "mettl.mindtickle.com"
    },
    {
      name = "ftp",
      type = "CNAME",
      ttl = "600",
      value = "@"
    },
    {
      name = "email",
      type = "CNAME",
      ttl = "600",
      value = "email.secureserver.net"
    },
    {
      name = "em",
      type = "CNAME",
      ttl = "600",
      value = "u284005.wl.sendgrid.net"
    },
    {
      name = "pda",
      type = "CNAME",
      ttl = "600",
      value = "mobilemail-v01.prod.mesa1.secureserver.net"
    },
    {
      name = "_domainconnect",
      type = "CNAME",
      ttl = "600",
      value = "_domainconnect.gd.domaincontrol.com"
    },
    {
      name = "support",
      type = "CNAME",
      ttl = "600",
      value = "mettl.freshdesk.com"
    },
    {
      name = "marketing",
      type = "CNAME",
      ttl = "600",
      value = "ci56.actonsoftware.com"
    },
    {
      name = "smtp",
      type = "CNAME",
      ttl = "600",
      value = "smtp.secureserver.net"
    },
    {
      name = "s2._domainkey",
      type = "CNAME",
      ttl = "600",
      value = "s2.domainkey.u284005.wl.sendgrid.net"
    },
    {
      name = "sonar",
      type = "A",
      ttl = "600",
      value = "52.77.81.51"
    },
    {
      name = "hs1._domainkey.mettlmails.net",
      type = "CNAME",
      ttl = "3600",
      value = "mettlmails-net.hs01a.dkim.hubspotemail.net"
    },
    {
      name = "hs2._domainkey.mettlmails.net",
      type = "CNAME",
      ttl = "3600",
      value = "mettlmails-net.hs01b.dkim.hubspotemail.net"
    },
    {
      name = "blog",
      type = "CNAME",
      ttl = "3600",
      value = "3030863.group13.sites.hubspot.net"
    },
    {
      name = "pages2",
      type = "CNAME",
      ttl = "3600",
      value = "3030863.group13.sites.hubspot.net"
    }
  ]

  root_mx_record_list = [
    "50	ASPMX3.GOOGLEMAIL.COM",
    "40	ASPMX2.GOOGLEMAIL.COM",
    "20	ALT1.ASPMX.L.GOOGLE.COM",
    "30	ALT2.ASPMX.L.GOOGLE.COM",
    "10	ASPMX.L.GOOGLE.COM"
  ]


  root_txt_record_list = [
    "v=spf1 include:_spf.google.com include:spf.mtasv.net ~all",
    "google-site-verification=iTbl6dL4AFKr65rAbMchb3hCPdWyrspE1E1o3kNlnqM",
    "google-site-verification=9WNLfeXSuI7qTBLcWbijP5OhzXH0tpJwiSN7clxRY1o",
    "google-site-verification=x9FUeumnS-eNzPt6FDpRhywS6HATuX-k1li7S_zinrg",
    "google-site-verification=GuKWyTCZ6Ze81ZqXywjwMhc42w908dpQNJqqaRYTNxU",
    "google-site-verification=CTQKEFkUIwl4LlC485fXJs0aamKuvtxlNe_yUZ_5-X0"
  ]

  txt_record_map = [
    {
      name = "pm._domainkey",
      value = "k=rsa; p=MHwwDQYJKoZIhvcNAQEBBQADawAwaAJhAIZ4gwriHfjI9lu1MhqwYxKr4BGU8APiysCzn1CeJHZnQW6RIfetAI8OHX0RuT1R+HxNFqcFA3X1H04WYC/rS1c3Mw/0/bRqc9t+TPFVyaeaP647b/xNy16xMU/h3Vz+tQIDAQAB"
    },
    {
      name = "20130527050506.pm._domainkey",
      value = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCA3ireGlSzhQO/EKgfFWY2vOpfaXcZcuN1FTQomYzkWyCN5ikTsQYSsT3p2YIWiWAqp8mqf8Os/KVsdekl2HNNFmtVe1X9Lz5PVg2b6fOV7Qy/wX8s2NVI9jw+0B/JVTNnTS5TV7D9FkHATMN5LtSCA50dzsiSnCGwGdMDbSl+lwIDAQAB"
    },
    {
      name = "smtpapi._domainkey.mettlmails.net",
      value = "k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPtW5iwpXVPiH5FzJ7Nrl8USzuY9zqqzjE0D1r04xDN6qwziDnmgcFNNfMewVKN2D1O+2J9N14hRprzByFwfQW76yojh54Xu3uSbQ3JP0A7k8o8GutRF8zbFUA8n0ZH2y0cIEjMliXY4W4LwPA7m4q0ObmvSjhd63O9d8z1XkUBwIDAQAB"
    }
  ]


  status_mettl_instance_type = "t2.nano"
  interviewApp_socket_instance_type = "t2.micro"
  interviewApp_admin_backend_instance_type = "t2.medium"
  interviewApp_admin_frontend_instance_type = "t2.medium"
  interviewApp_candidate_backend_instance_type = "t2.medium"
  interviewApp_candidate_frontend_instance_type = "t2.medium"
  report_corporate_instance_type = "m4.large"
  proctoring-ui = {

    lc_ami = "ami-81bff2ee"
    lc_instance_type = "t2.small"
    user_data_file_name = "../proctoring-userdata"
    as_max_size = "2"
    as_min_size = "1"
    # as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    scale_up_consecutive_periods = "1"
    scale_up_period = "300"
    cpu_high_threshold = "30"
    scale_down_consecutive_periods = "2"
    scale_down_period = "300"
    cpu_low_threshold = "10"
    scale_down_by_instances = "-1"
    scale_up_by_instances = "1"
    scale_up_warmup = "100"
  }

  application-grader = {
    lc_ami = "ami-7cbdf013"
    lc_instance_type = "t2.medium"
    user_data_file_name = "../application-grader-userdata"
    as_max_size = "10"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "60"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    low_queue_size_threshold = "10"
    scale_down_by_instances = "-1"
    high_queue_size_threshold = "50"
    scale_up_period = "60"
    scale_down_period = "60"
    scale_up_by_instances = "1"
    queue = "applicationGrader"
    scale_down_consecutive_periods = "1"
    scale_up_consecutive_periods = "1"
    scale_up_cooldown = "300"
    scale_down_cooldown = "300"


  }
  pr = {
    lc_ami = "ami-c9bcf1a6"
    lc_instance_type = "t2.medium"
    user_data_file_name = "../pr-userdata"
    as_max_size = "10"
    as_min_size = "2"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "ELB"

  }

  mettl-api = {
    lc_ami = "ami-45c8e12a"
    lc_instance_type = "r3.large"
    user_data_file_name = "../mettl-api-userdata"
    as_max_size = "10"
    as_min_size = "2"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "ELB"

  }

  windows_codeproject_instance_ebs_optimized = "true"

  labs_instance_type = "t2.small"
  labs_1_backend_instance_type = "c4.large"
  labs_2_backend_instance_type = "c4.large"


  janus_live_feed_service = {
    lc_ami = "ami-9a98baf5"
    lc_instance_type = "c4.xlarge"
    user_data_file_name = "../janus-livefeed-service-userdata"
    as_max_size = "10"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
  }


  redis_cache_type = "cache.t2.medium"


  cos-api = {
    lc_ami = "ami-83b492ec"
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
    elb_idle_timeout = "600"
    set_connection_draining = true
    connection_draining_timeout = "300"
    elb_logs_interval = "60"
    elb_logs_enabled = "true"
    scale_up_consecutive_periods = "1"
    scale_up_period = "300"
    cpu_high_threshold = "90"
    scale_down_consecutive_periods = "2"
    scale_down_period = "300"
    cpu_low_threshold = "50"
    scale_down_by_instances = "-1"
    scale_up_by_instances = "1"
    scale_up_warmup = "100"
  }

  report-ui = {
    lc_ami = "ami-740c471b"
    lc_instance_type = "t2.medium"
    user_data_file_name = "../report-ui-userdata"
    as_max_size = "5"
    as_min_size = "1"
    # as_desired_size = "1"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    scale_up_consecutive_periods = "1"
    scale_up_period = "300"
    cpu_high_threshold = "80"
    scale_down_consecutive_periods = "2"
    scale_down_period = "300"
    cpu_low_threshold = "50"
    scale_down_by_instances = "-1"
    scale_up_by_instances = "1"
    scale_up_warmup = "100"
  }



  email-service = {

    lc_ami = "ami-fb015494"
    lc_instance_type = "t2.small"
    user_data_file_name = "../email-service-userdata"
    as_max_size = "5"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "60"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    low_queue_size_threshold = "5"
    scale_down_by_instances = "-1"
    high_queue_size_threshold = "50"
    scale_up_period = "60"
    scale_down_period = "60"
    scale_up_by_instances = "1"
    queue = "email"
    scale_down_consecutive_periods = "15"
    scale_up_consecutive_periods = "5"
    scale_up_cooldown = "300"
    scale_down_cooldown = "300"


  }
  mettl-api-gateway = {
    lc_ami = "ami-64cbe20b"
    lc_instance_type = "r4.large"
    user_data_file_name = "../mettl-api-gateway-userdata"
    as_max_size = "10"
    as_min_size = "2"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "ELB"

  }
  janus_stun_server_address = "52.77.142.113"
  janus_stunserver_port = "3478"
  question-service = {
    lc_ami = "ami-9f104bf0"
    lc_instance_type = "t2.large"
    as_max_size = "10"
    as_min_size = "2"
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

  report-service-api = {
    lc_ami = "ami-cf2b0ea0"
    lc_instance_type = "t2.medium"
    user_data_file_name = "./../report-service-api-userdata"
    as_max_size = "10"
    as_min_size = "2"
    # as_desired_size = "0"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "ELB"
    health_check_response_timeout = "4"
    health_check_interval = "5"
    elb_idle_timeout = "600"
    set_connection_draining = true
    connection_draining_timeout = "300"
    elb_logs_interval = "60"
    elb_logs_enabled = "true"
    scale_up_consecutive_periods = "1"
    scale_up_period = "300"
    cpu_high_threshold = "90"
    scale_down_consecutive_periods = "2"
    scale_down_period = "300"
    cpu_low_threshold = "50"
    scale_down_by_instances = "-1"
    scale_up_by_instances = "1"
    scale_up_warmup = "100"
  }

  assessment-service = {
    lc_ami = "ami-0a341165"
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
    elb_idle_timeout = "600"
    set_connection_draining = true
    connection_draining_timeout = "300"
    elb_logs_interval = "60"
    elb_logs_enabled = "true"
    scale_up_consecutive_periods = "1"
    scale_up_period = "300"
    cpu_high_threshold = "90"
    scale_down_consecutive_periods = "2"
    scale_down_period = "300"
    cpu_low_threshold = "50"
    scale_down_by_instances = "-1"
    scale_up_by_instances = "1"
    scale_up_warmup = "100"
  }

  r-simulator-spi = {
    lc_ami = "ami-11fad97e"
    lc_instance_type = "t2.micro"
    as_max_size = "1"
    as_min_size = "1"
    # as_desired_size = "2"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    elb_idle_timeout = "600"
    set_connection_draining = true
    connection_draining_timeout = "100"

  }

  r-socket = {

    lc_ami = "ami-b1f8dbde"
    lc_instance_type = "t2.small"
    as_max_size = "1"
    as_min_size = "1"
    #  as_desired_size = "1"
    as_default_cooldown = "100"
    health_check_grace_period = "300"
    health_check_type = "EC2"
  }

  r-simulator-cms = {
    lc_ami = "ami-d1fcd3be"
    lc_instance_type = "c4.large"
    as_max_size = "2"
    as_min_size = "2"
    # as_desired_size = "2"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    elb_idle_timeout = "600"
    set_connection_draining = true
    connection_draining_timeout = "100"

  }

  ucl-codelysis-revert = {
    lc_ami = "ami-953463fa"
    lc_instance_type = "c4.large"
    as_max_size = "20"
    as_min_size = "0"
    # as_desired_size = "2"
    as_default_cooldown = "300"
    health_check_grace_period = "300"
    health_check_type = "EC2"
    health_check_response_timeout = "9"
    health_check_interval = "10"
    elb_idle_timeout = "600"
    set_connection_draining = true
    connection_draining_timeout = "100"
    elb_logs_interval = "60"
    elb_logs_enabled = "true"
    scale_up_consecutive_periods = "1"
    scale_up_period = "60"
    cpu_high_threshold = "50"
    scale_down_consecutive_periods = "5"
    scale_down_period = "60"
    cpu_low_threshold = "20"
    scale_down_by_instances = "-1"
    scale_up_by_instances = "2"
    scale_up_warmup = "100"
  }

  almdigital_instance_type = "t2.micro"
  jobvite_instance_type = "t2.micro"

  blue-green = {
    lc_ami = "ami-3082d85f"
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

}