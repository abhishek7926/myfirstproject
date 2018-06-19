class MyJob{
    public String jobName

    MyJob(jobName){
        this.jobName=jobName
    }
}

def jobList = [new MyJob('Start-Janus-and-LiveFeedService-On-SpecificMachine')
]

jobList.each{ k ->
    job("${k.jobName}") {
        description("This job will start janus and livefeed service")
        parameters{
            stringParam('ip')
        }

        steps {
            shell(
                    "#!/bin/bash\n" +
                            "set -x\n" +
                            'if nc -w 1 -z $ip 8085; then\n'+
                            'echo \"already running"\n'+
                            'else\n'+
                            'ssh -o StrictHostKeyChecking=no ubuntu@$ip "\n' +
                            "sudo start janus\n" +
                            "sudo su mettl -c '/home/mettl/release/java-services/startJavaService.sh livefeed-server'\n" +
                            "\""+
                            '\n'+

                            'fi'

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