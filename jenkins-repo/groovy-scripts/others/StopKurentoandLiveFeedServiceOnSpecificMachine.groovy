class MyJob{
    public String jobName

    MyJob(jobName){
        this.jobName=jobName
    }
}

def jobList = [new MyJob('Stop-Kurento-and-LiveFeedService-On-SpecificMachine')
]

jobList.each{ k ->
    job("${k.jobName}") {
        description("This job will stop kurento and livefeed service")
        parameters{
            stringParam('ip')
        }

        steps {
            shell('#!/bin/bash\n' +
                    "set -x\n" +
                    'if nc -w 1 -z $ip 8085; then\n'+
                    "echo \"kurento is running\"\n" +
                    'ssh -o StrictHostKeyChecking=no ubuntu@$ip "\n' +
                    "sudo service kurento-media-server-6.0 stop\n" +
                    "\"\n" +
                    "else \n" +
                    "echo \"kurento is already not running\"\n" +
                    "\n" +
                    "fi"

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