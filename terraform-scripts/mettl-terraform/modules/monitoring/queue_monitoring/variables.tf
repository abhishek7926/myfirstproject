variable "monitoring_params" {type="map"
  default ={
    period = 60
    evaluation_period = 1
  }}
variable "queue_notification" {type="map"}
variable "enable_monitoring" {}
variable "env" {}
variable "private_dns_zone_name" {}
variable "queues_with_at_least_one_consumer" {
  type="list",
  default= [
{ queue-name = "applicationGrader",  queue_size_threshold ="30"},
{ queue-name = "auiQueue",  queue_size_threshold ="30"},
{ queue-name = "authBlockedCandidate",  queue_size_threshold ="10"},
{ queue-name = "bulkPdf",  queue_size_threshold ="5"},
{ queue-name = "candidateEvent",  queue_size_threshold ="50"},
{ queue-name = "excelRequest",  queue_size_threshold ="10"},
{ queue-name = "grader",  queue_size_threshold ="25"},
{ queue-name = "itemAnalysisExcel",  queue_size_threshold ="10"},
{ queue-name = "largeExcelRequest",  queue_size_threshold ="10"},
{ queue-name = "largeInferentialExcelRequest",  queue_size_threshold ="10"},
{ queue-name = "proctoring",  queue_size_threshold ="1000"},
{ queue-name = "revaluation",  queue_size_threshold ="30"},
{ queue-name = "chat_streaming_connection",  queue_size_threshold ="5"},
{ queue-name = "chat_streaming_messages",  queue_size_threshold ="5"},
{ queue-name = "ws_binary_chat_queues_send_queue",  queue_size_threshold ="5"},
{ queue-name = "ws_chat_queues_adminAckMessageQueue",  queue_size_threshold ="5"},
{ queue-name = "ws_chat_queues_sendQueue",  queue_size_threshold ="5"},
{ queue-name = "email",  queue_size_threshold ="200"},
{ queue-name = "proctoring_java",  queue_size_threshold ="5000"}

]

}

variable "queues_with_exactly_one_consumer" {
  type="list",

  default= [
    { queue-name = "accountActivity",queue_size_threshold ="200"},
    { queue-name = "cpc",queue_size_threshold ="3"},
    { queue-name = "manageEnterpriseBillingAmount",queue_size_threshold ="50"},
    { queue-name = "scheduler",queue_size_threshold ="10"},
    { queue-name = "testNotification",queue_size_threshold ="10"},
    { queue-name = "binary_chat_queues_receive_queue",queue_size_threshold ="5"},
    { queue-name = "binary_chat_queues_send_queue",queue_size_threshold ="5"},
    { queue-name = "chat_queues_adminAckMessageQueue",queue_size_threshold ="5"},
    { queue-name = "chat_queues_adminMessageQueue",queue_size_threshold ="5"},
    { queue-name = "chat_queues_receiveQueue",queue_size_threshold ="5"},
    { queue-name = "chat_queues_sendQueue",queue_size_threshold ="5"},
    { queue-name = "ws_chat_queues_adminMessageQueue",queue_size_threshold ="5"}

  ]

}