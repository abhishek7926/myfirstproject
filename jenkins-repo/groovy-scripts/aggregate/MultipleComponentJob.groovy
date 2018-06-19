class Aggregation{
    public String umbrella
    public ArrayList downstreamJobList
    Aggregation(umbrella,downstreamJobList){
        this.umbrella=umbrella
        this.downstreamJobList=downstreamJobList
    }
}

classfication_list=
        [
                new Aggregation(
                        "SkillMaster",
                        ['SkillMaster-admin', 'SkillMaster-special', 'SkillMaster-general' ]
                ),
                new Aggregation(
                        "Grader",
                        ['GraderExceptApplication', 'ApplicationGrader']
                ),
                new Aggregation(
                        "LiveFeedServer",
                        ['Kurento-livefeed-server', 'Janus-livefeed-server']
                ),
                new Aggregation(
                        "LABS_USERS",
                        ['LabsUsers1', 'LabsUsers2']
                )
        ]

manage_service_operation_list=["Deploy", "Stop", "Start", "Restart"]


manage_service_operation_list.each { operation ->
    classfication_list.each { classification ->
        if( operation == "Deploy" ) {
            job_name="Generic${classification.umbrella}Deployer"
        }else{
            job_name="Generic${operation}${classification.umbrella}"
        }
        job(job_name) {
            description('This job will take input for enviornment deployment')
            parameters {
                stringParam('Description')
            }
            if( operation == "Deploy" ) {
                parameters {
                    stringParam('versionNum')
                }

            }
            wrappers {
                buildUserVars()
            }

            steps {
                shell('#!/bin/bash\n' +
                        'echo "Delegating request to downstream jobs for actual deployment: revision number ${versionNum}"'
                )
            }
            publishers {
                flexiblePublish {
                    classification.downstreamJobList.each { k ->
                        conditionalAction {
                            condition {
                                alwaysRun()
                            }
                            publishers {
                                downstreamParameterized {
                                    if( operation == "Deploy" ) {
                                        trigger("Generic${k}Deployer") {
                                            condition('SUCCESS')
                                            parameters {
                                                currentBuild()
                                            }
                                        }
                                    }else{
                                        trigger("Generic${operation}${k}") {
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
            }
        }
    }
}
