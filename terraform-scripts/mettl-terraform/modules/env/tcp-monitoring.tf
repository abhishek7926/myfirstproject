module "tcp-monitoring" {
  source = "../monitoring/tcp-monitoring"
  env = "${var.env}"
  enable_monitoring = "${var.enable_monitoring}"
  private_dns_zone_name = "${var.private_dns_zone_name}"

  tcp_services = [
{
      name = "static",
      port = "9052",
      sns = "${module.platform_sns.sns_arn}"
    },
    {
      name = "htmltopdf",
      port = "8030",
      sns = "${module.reporting_sns.sns_arn}"
    },
    {
      name = "streaming",
      port = "1989",
      sns = "${module.proctoring_sns.sns_arn}"
    },
    {
      name = "streaming",
      port = "1988",
      sns = "${module.proctoring_sns.sns_arn}"
    },
    {
      name = "chat-socket",
      port = "1988",
      sns = "${module.proctoring_sns.sns_arn}"
    },
    {
      name = "chat-socket",
      port = "1987",
      sns = "${module.proctoring_sns.sns_arn}"
    },
    {
      name = "java-codelysis",
      port = "7896",
      sns = "${module.simulators_sns.sns_arn}"
    },
    {
      name = "ucl-code-project",
      port = "9411",
      sns = "${module.simulators_sns.sns_arn}"
    },
    {
      name = "ucl-codelysis-android",
      port = "9411",
      sns = "${module.simulators_sns.sns_arn}"
    },
    {
      name = "ucl-codelysis",
      port = "9411",
      sns = "${module.simulators_sns.sns_arn}"
    },
    {
      name = "windows-codelysis",
      port = "9012",
      sns = "${module.simulators_sns.sns_arn}"
    },
    {
      name = "windows-codelysis",
      port = "1521",
      sns = "${module.simulators_sns.sns_arn}"
    },
    {
      name = "windows-codelysis",
      port = "3306",
      sns = "${module.simulators_sns.sns_arn}"
    },
    {
      name = "windows-codeproject",
      port = "9411",
      sns = "${module.simulators_sns.sns_arn}"
    },
    {
      name = "windows-codeproject",
      port = "1433",
      sns = "${module.simulators_sns.sns_arn}"
    },
    {
      name = "intellisense",
      port = "8001",
      sns = "${module.apps_sns.sns_arn}"
    },
    {
      name = "fes",
      port = "9880",
      sns = "${module.simulators_sns.sns_arn}"
    },
    {
      name = "dblysis",
      port = "9013",
      sns = "${module.simulators_sns.sns_arn}"
    },
    {
      name = "schema",
      port = "9999",
      sns = "${module.simulators_sns.sns_arn}"
    },
    {
      name = "typing-simulator",
      port = "9900",
      sns = "${module.simulators_sns.sns_arn}"
    },
    {
      name = "english-simulator",
      port = "5000",
      sns = "${module.simulators_sns.sns_arn}"
    },
    {
      name = "activemq",
      port = "61616",
      sns = "${module.platform_core_server_sns.sns_arn}"
    },
    {
      name = "activemq",
      port = "8161",
      sns = "${module.platform_core_server_sns.sns_arn}"
    },
    {
      name = "chat-activemq",
      port = "8161",
      sns = "${module.platform_core_server_sns.sns_arn}"
    },
    {
      name = "chat-activemq",
      port = "61616",
      sns = "${module.platform_core_server_sns.sns_arn}"
    },
    {
      name = "mongo-primary-new",
      port = "27017",
      sns = "${module.platform_core_server_sns.sns_arn}"
    },
    {
      name = "mongo-primary-member2-new",
      port = "27017",
      sns = "${module.platform_core_server_sns.sns_arn}"
    },
    {
      name = "mongo-primary-arbiter-new",
      port = "27017",
      sns = "${module.platform_core_server_sns.sns_arn}"
    },
    {
      name = "mongo-light-new",
    port = "27017",
    sns = "${module.platform_core_server_sns.sns_arn}"
    },
    {
      name = "mongo-light-member2-new",
    port = "27017",
    sns = "${module.platform_core_server_sns.sns_arn}"
    },
    {
      name = "mongo-light-member3-new",
      port = "27017",
      sns = "${module.platform_core_server_sns.sns_arn}"
    },
    {
      name = "redis",
      port = "6379",
    sns = "${module.platform_core_server_sns.sns_arn}"
    },
    {
      name ="nfs",
      port = "2049",
      sns = "${module.platform_core_server_sns.sns_arn}"
    },
    {
      name ="master-1-elasticsearch",
      port = "9200",
      sns = "${module.question_services_sns.sns_arn}"
    },
    {
      name ="master-2-elasticsearch",
      port = "9200",
      sns = "${module.question_services_sns.sns_arn}"
    },{
      name ="master-3-elasticsearch",
      port = "9200",
      sns = "${module.question_services_sns.sns_arn}"
    },{
      name ="data-1-elasticsearch",
      port = "9200",
      sns = "${module.question_services_sns.sns_arn}"
    },{
      name ="data-2-elasticsearch",
      port = "9200",
      sns = "${module.question_services_sns.sns_arn}"
    },
    {
      name ="master-1-elasticsearch",
      port = "9300",
      sns = "${module.question_services_sns.sns_arn}"
    },
    {
      name ="master-2-elasticsearch",
      port = "9300",
      sns = "${module.question_services_sns.sns_arn}"
    },{
      name ="master-3-elasticsearch",
      port = "9300",
      sns = "${module.question_services_sns.sns_arn}"
    },{
      name ="data-1-elasticsearch",
      port = "9300",
      sns = "${module.question_services_sns.sns_arn}"
    },{
      name ="data-2-elasticsearch",
      port = "9300",
      sns = "${module.question_services_sns.sns_arn}"
    },
    {
      name = "interviewapp-admin-frontend",
      port = "80",
      sns = "${module.apps_sns.sns_arn}"
    },
    {
      name = "interviewapp-admin-backend",
      port = "8084",
      sns = "${module.apps_sns.sns_arn}"
    },
    {
      name = "interviewapp-candidate-frontend",
      port = "80",
      sns = "${module.apps_sns.sns_arn}"
    },
    {
      name = "interviewapp-candidate-backend",
      port = "8083",
      sns = "${module.apps_sns.sns_arn}"
    },
    {
      name = "labs-1-backend",
      port = "8000",
      sns = "${module.apps_sns.sns_arn}"
    },
    {
      name = "labs-1-backend",
      port = "8787",
      sns = "${module.apps_sns.sns_arn}"
    },
    {
      name = "labs-2-backend",
      port = "8000",
      sns = "${module.apps_sns.sns_arn}"
    },
    {
      name = "labs-2-backend",
      port = "8787",
      sns = "${module.apps_sns.sns_arn}"
    },
    {
      name = "labs-1-backend",
      port = "8095",
      sns = "${module.apps_sns.sns_arn}"
    },
    {
      name = "labs-2-backend",
      port = "8095",
      sns = "${module.apps_sns.sns_arn}"
    },
    {
      name = "labs-api",
      port = "8089",
      sns = "${module.apps_sns.sns_arn}"
    }



    ]


}
