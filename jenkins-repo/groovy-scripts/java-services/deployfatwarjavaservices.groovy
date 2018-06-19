class MyJob{
    public String jobName
    public String artifactName
    public String server
    MyJob(jobName,artifactName, server){
        this.jobName=jobName
        this.artifactName=artifactName
        this.server=server
    }
}
def jobList = [new MyJob('Hackathon_App', 'hackathon-app', 'hackathon'),
]

jobList.each{ k ->
    serverUrl="${k.server}.${InternalDomain}"
    job("Generic${k.jobName}Deployer") {
        description("This job will deploy the ${k.jobName} on the target server")
        parameters{
            stringParam('versionNum')
        }
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/java-services/stopJavaService.sh '+"${k.artifactName}"+'"\n'+
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/java-services/deployJavaWarService.sh $versionNum '+ "${k.artifactName}"+'"\n'+
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/java-services/startJavaWarService.sh '+ "${k.artifactName}"+'"\n'
            )
        }
    }
    job("GenericStop${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/java-services/stopJavaService.sh '+ "${k.artifactName}"+'"\n'

            )
        }
    }

    job("GenericStart${k.jobName}") {
        description("This job will start the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/java-services/startJavaWarService.sh '+ "${k.artifactName}"+'"\n'

            )
        }
    }

    job("GenericRestart${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/java-services/stopJavaService.sh '+ "${k.artifactName}"+'"\n'+
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/java-services/startJavaWarService.sh '+ "${k.artifactName}"+'"\n'

            )
        }
    }
}