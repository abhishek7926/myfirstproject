class MyJob{
    public String jobName

    MyJob(jobName){
        this.jobName=jobName
    }
}

def jobList = [new MyJob('Stop-Janus-and-LiveFeedService-On-SpecificMachine')
]

jobList.each{ k ->
    job("${k.jobName}") {
        description("This job will stop janus and livefeed service")
        parameters{
            stringParam('ip')
        }

        steps {
            shell(
                    "#!/bin/bash\n" +
                            "set -x\n" +
                            'ssh -o StrictHostKeyChecking=no ubuntu@$ip "\n' +
                            "sudo stop janus\n" +
                            "\""

            )
        }
        publishers {
            extendedEmail {
                defaultSubject("(${ENV} environment) " + '$DEFAULT_SUBJECT')
                defaultContent(
                        'Started By: $BUILD_USER\n' +
                                '\n' +
                                'Check console output at $BUILD_URL to view the results.\n'
                                )
                triggers {
                    always {
                    }
                }
            }
        }
    }
}