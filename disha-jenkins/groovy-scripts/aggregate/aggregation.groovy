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
                        "Disha",
                        [
                                new DownStreamJob('Disha_Web', 'DishaWeb'),
                                new DownStreamJob('Disha_Cms', 'DishaCms'),
                                new DownStreamJob('Disha_Web_Tcmap', 'DishaWebTcmap'),
                                new DownStreamJob('Disha_Location', 'DishaLocation'),
                                new DownStreamJob('Disha_Username', 'DishaUsername'),
                                new DownStreamJob('Disha_Ifsc', 'DishaIfsc'),
                                new DownStreamJob('Disha_Eligibility', 'DishaEligibility'),
                                new DownStreamJob('Disha_Pmgdisha_info', 'DishaPmgdishaInfo'),
                                new DownStreamJob('Biometric', 'Biometric'),
                                new DownStreamJob('Biometric_Admin', 'BiometricAdmin'),
                                new DownStreamJob('Certificate_App', 'CertificateApp'),
                                new DownStreamJob('Reporting_DB_Update_Service', 'ReportingDBUpdateService'),
                                new DownStreamJob('Disha_CMS_Resource', 'DishaCMSResources'),
                                new DownStreamJob('Disha_Web_Resource', 'DishaWebResources'),
                                new DownStreamJob('Practice_App', 'PracticeApp'),
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
