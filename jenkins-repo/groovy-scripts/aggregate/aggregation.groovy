class DownStreamJob{
    public String booleanName
    public String downstreamJob
    DownStreamJob(booleanName,downstreamJob){
        this.booleanName=booleanName
        this.downstreamJob=downstreamJob
    }
}

class Aggregation{
    public String umbrella
    public ArrayList downstreamJobList
    Aggregation(umbrella,downstreamJobList){
        this.umbrella=umbrella
        this.downstreamJobList=downstreamJobList
    }
}

manage_service_operation_list=["Deploy", "Stop", "Start", "Restart"]

classfication_list=
        [
                new Aggregation(
                    "Chat-Apps",
                    [
                        new DownStreamJob('Chat_Socket_App', 'ChatSocket'),
                        new DownStreamJob('Chat_Service', 'ChatService'),
                        new DownStreamJob('Proctoring_Static', 'ProctoringStatic'),
                        new DownStreamJob('LiveFeed_Router', 'LiveFeedRouter'),
                        new DownStreamJob('LiveFeed_Server', 'LiveFeedServer'),
                        new DownStreamJob('Chat_Web_Socket', 'ChatWebSocket'),
                        new DownStreamJob('PROCTORING_SERVICE', 'ProctoringService'),
                        new DownStreamJob('STREAMING_SERVER', 'StreamingServer'),
                        new DownStreamJob('Proctoring_UI', 'Proctoring-Ui'),
                        new DownStreamJob('MpsService', 'Mpaas'),
                        new DownStreamJob('JAVA_MIP', 'Java-MIP'),
                    ]
                ),
                new Aggregation(
                    "Mettl-Apps",
                    [
                        new DownStreamJob('PRELOGIN', 'PreLogin'),
                        new DownStreamJob('CERTIFICATION', 'Certification'),
                        new DownStreamJob('360FEEDBACK', '360Feedback'),
                        new DownStreamJob('IGT', 'IGT'),
                        new DownStreamJob('HPE', 'HPE'),
                        new DownStreamJob('NDLM', 'NDLM'),
                        new DownStreamJob('DUOLINGO', 'DuoLingo'),
                        new DownStreamJob('NOTIFICATION_APP', 'MettlNotificationApp'),
                        new DownStreamJob('ACCENTURE_APP', 'Accenture'),
                        new DownStreamJob('CLIENT_API', 'ClientApi'),
                        new DownStreamJob('TEST_NOTIFICATION', 'TestNotification'),
                        new DownStreamJob('FEEDBACK', 'Feedback'),
                        new DownStreamJob('UBER', 'Uber'),
                        new DownStreamJob('STATUS_APP', 'StatusApp'),
                        new DownStreamJob('LABS_API', 'LabsAPI'),
                        new DownStreamJob('LABS_USERS', 'LABS_USERS'),
                        new DownStreamJob('Jobvite_App', 'Jobvite')
                    ]
                ),
                new Aggregation(
                    "Mettl-All-Component",
                    [
                        new DownStreamJob('BULK_PDF', 'BulkPdfService'),
                        new DownStreamJob('AUI', 'AUI'),
                        new DownStreamJob('METTL_API', 'MettlApi'),
                        new DownStreamJob('ADMIN_PANEL', 'AdminPanel'),
                        new DownStreamJob('SKILL_MASTER', 'SkillMaster'),
                        new DownStreamJob('EXCEL_SERVICE', 'ExcelService'),
                        new DownStreamJob('LARGE_EXCEL_SERVICE', 'LargeExcelService'),
                        new DownStreamJob('CORPORATE', 'Corporate'),
                        new DownStreamJob('REPORT_UI','ReportUI'),
                        new DownStreamJob('REPORT_SERVICE', 'ReportService'),
                        new DownStreamJob('GRADER', 'Grader'),
                        new DownStreamJob('Email_service','EmailService'),
                        new DownStreamJob('SCHEDULER', 'Scheduler'),
                        new DownStreamJob('PROCTORING_SCHEDULER', 'SchedulerCandidateEvent'),
                        new DownStreamJob('CODELYSIS', 'Codelysis'),
                        new DownStreamJob('DBLYSIS', 'Dblysis'),
                        new DownStreamJob('TYPING_SIMULATOR', 'TypingSimulator'),
                        new DownStreamJob('CONTEST', 'Contest'),
                        new DownStreamJob('LMS', 'LMS'),
                        new DownStreamJob('API_DEMO', 'ApiDemo'),
                        new DownStreamJob('SCHEMA_SERVICE', 'SchemaService'),
                        new DownStreamJob('FES', 'Fes'),
                        new DownStreamJob('PR', 'PR'),
                        new DownStreamJob('UCL_CodeProject', 'UCLCodeProject'),
                        new DownStreamJob('UCL_Codelysis', 'UCLCodelysis'),
                        new DownStreamJob('UCL_Android', 'UCLCodelysisAndroid'),
                        new DownStreamJob('CODING_SIMULATOR', 'CodingSimulator'),
                        new DownStreamJob('MEDIA_SERVICE', 'MediaService'),
                        new DownStreamJob('MOBILE_APP', 'MobileApp'),
                        new DownStreamJob('HTML_TO_PDF', 'HtmlToPdfService'),
                        new DownStreamJob('ENGLISH_SIMULATOR', 'EnglishSimulator'),
			            new DownStreamJob('QUESTION_SERVICE', 'QuestionService'),
			            new DownStreamJob('QUESTION_EVENT_SERVICE', 'QuestionEventService'),
                        new DownStreamJob('CLEAR_REDIS_CACHE', 'RedisCacheFlush'),
                        new DownStreamJob('CLEAR_REDIS_USER_SESSION_CACHE', 'RedisUserSessionCacheFlush'),
                        new DownStreamJob('COS', 'COS'),
                        new DownStreamJob('Report_Service_Api','ReportServiceApi'),
                        new DownStreamJob('Assessment_Service','AssessmentService')
                    ]
                ),
                new Aggregation(
                        "Intellisense",
                        [
                                new DownStreamJob('Intellisense_Router', 'IntellisenseRouter'),
                                new DownStreamJob('Python_Intellisense', 'PythonIntellisense'),
                                new DownStreamJob('Intellisense_java', 'IntellisenseJava')
                        ]
                ),
                new Aggregation(
                        "InterviewApp",
                        [
                                new DownStreamJob('IntervuewApp_Admin_API', 'InterviewappAdminAPI'),
                                new DownStreamJob('IntervuewApp_Candidate_API', 'InterviewappCandidateAPI'),
                                new DownStreamJob('IntervuewApp_Admin_Web', 'InterviewappAdminWeb'),
                                new DownStreamJob('IntervuewApp_Candidate_Web', 'InterviewappCandidateWeb'),
                                new DownStreamJob('IntervuewApp_WebSocket', 'InterviewappSocket'),
                        ]
                ),

                new Aggregation(
                        "Simulators",
                        [
                                new DownStreamJob('R_SIMULATOR_ROUTER', 'RSimulatorRouter'),
                                new DownStreamJob('R_SIMULATOR_SPI', 'RSimulatorSPI'),
                                new DownStreamJob('R_SIMULATOR_SOCKET', 'RSimulatorSocket'),
                                new DownStreamJob('R_SIMULATOR_CMS', 'RSimulatorCMS'),
                                new DownStreamJob('Mean_SIMULATOR_CMS', 'MeanSimulatorCMS'),
                                new DownStreamJob('Mean_SIMULATOR_ROUTER', 'MeanSimulatorRouter'),
                                new DownStreamJob('Mean_Static', 'MeanStatic'),
                        ]
                )
        ]





manage_service_operation_list.each { operation ->
    classfication_list.each { classification ->
        job("${operation}-${classification.umbrella}") {
            description('This job will take input for enviornment deployment')
            if( operation == "Deploy" ) {
                parameters {
                    stringParam('versionNum')
                }

            }
            parameters {
                stringParam('Description')
            }
            wrappers {
                buildUserVars()
            }

            steps {
                shell('#!/bin/bash\n' +
                        'echo "Delegating request to downstream jobs for actual deployment: revision number ${versionNum}"'
                )
            }
            classification.downstreamJobList.each { k ->
                parameters {
                    booleanParam("${k.booleanName}")
                }
            }



            publishers {
                flexiblePublish {
                    classification.downstreamJobList.each { k ->
                        conditionalAction {
                            condition {
                                booleanCondition("\$${k.booleanName}")
                            }
                            publishers {
                                downstreamParameterized {
                                    if( operation == "Deploy" ) {
                                        trigger("Generic${k.downstreamJob}Deployer") {
                                            condition('SUCCESS')
                                            parameters {
                                                currentBuild()
                                            }
                                        }
                                    }else{
                                        trigger("Generic${operation}${k.downstreamJob}") {
                                            condition('SUCCESS')
                                            parameters {
                                                currentBuild()
                                            }
                                        }

                                    }
                                }
                            }
                        }

                    }
                }
                extendedEmail {
                    defaultSubject("(${ENV} environment) " + '$DEFAULT_SUBJECT (Version Number: $versionNum)')
                    defaultContent(
                            'Started By: $BUILD_USER\n' +
                                    '\n' +
                                    'Check console output at $BUILD_URL to view the results.\n' +
                                    '\n' +
                                    'Components:\n' +
                                    '${BUILD_LOG_REGEX, regex="^.*?enabling perform", showTruncatedLines=false, linesBefore=1}')
                    triggers {
                        always {
                        }
                    }
                }
            }
        }
    }
}
