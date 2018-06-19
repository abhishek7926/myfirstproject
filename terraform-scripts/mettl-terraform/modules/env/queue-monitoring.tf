
module "queue-monitoring" {
  source = "../monitoring/queue_monitoring"
  env = "${var.env}"
  enable_monitoring = "${var.enable_monitoring}"
private_dns_zone_name = "${var.private_dns_zone_name}"
  queue_notification = {

accountActivity = "${module.platform_sns.sns_arn}"
applicationGrader = "${module.platform_sns.sns_arn}"
auiQueue = "${module.platform_sns.sns_arn}"
authBlockedCandidate = "${module.platform_sns.sns_arn}"
bulkPdf = "${module.platform_sns.sns_arn}"
candidateEvent = "${module.platform_sns.sns_arn}"
cpc = "${module.platform_sns.sns_arn}"
excelRequest = "${module.platform_sns.sns_arn}"
grader = "${module.platform_sns.sns_arn}"
itemAnalysisExcel = "${module.platform_sns.sns_arn}"
largeExcelRequest = "${module.platform_sns.sns_arn}"
largeInferentialExcelRequest = "${module.platform_sns.sns_arn}"
manageEnterpriseBillingAmount = "${module.platform_sns.sns_arn}"
proctoring = "${module.platform_sns.sns_arn}"
revaluation = "${module.platform_sns.sns_arn}"
scheduler = "${module.platform_sns.sns_arn}"
testNotification = "${module.platform_sns.sns_arn}"
binary_chat_queues_receive_queue = "${module.platform_sns.sns_arn}"
binary_chat_queues_send_queue = "${module.platform_sns.sns_arn}"
chat_queues_adminAckMessageQueue = "${module.platform_sns.sns_arn}"
chat_queues_adminMessageQueue = "${module.platform_sns.sns_arn}"
chat_queues_receiveQueue = "${module.platform_sns.sns_arn}"
chat_queues_sendQueue = "${module.platform_sns.sns_arn}"
chat_streaming_connection = "${module.platform_sns.sns_arn}"
chat_streaming_messages = "${module.platform_sns.sns_arn}"
ws_binary_chat_queues_send_queue = "${module.platform_sns.sns_arn}"
ws_chat_queues_adminAckMessageQueue = "${module.platform_sns.sns_arn}"
ws_chat_queues_adminMessageQueue = "${module.platform_sns.sns_arn}"
ws_chat_queues_sendQueue = "${module.platform_sns.sns_arn}"
email="${module.platform_sns.sns_arn}"
    proctoring_java = "${module.platform_sns.sns_arn}"

    }
    
  }

