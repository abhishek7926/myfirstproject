class MyJob{
    public String jobName
    public String artifactName
    public String server
    public String optionalArgs
    MyJob(jobName,artifactName, server, optionalArgs){
        this.jobName=jobName
        this.artifactName=artifactName
        this.server=server
        this.optionalArgs=optionalArgs
    }
}
def jobList = [
        new MyJob('ProctoringService', 'proctoring', 'proctoring', ''),
        new MyJob('InterviewappAdminAPI', 'admin-api', 'interviewapp-admin-backend', '-Dserver.port=8084'),
        new MyJob('InterviewappCandidateAPI', 'interview-api', 'interviewapp-candidate-backend', '-Dserver.port=8083'),
        new MyJob('LabsAPI', 'labs-api', 'labs-api', ''),
        new MyJob('LabsUsers1', 'labs-user-manage', 'labs-4-backend', ''),
        new MyJob('LabsUsers2', 'labs-user-manage', 'labs-5-backend', ''),
        new MyJob('Jobvite', 'jobvite-integration-app', 'jobvite', ''),
        new MyJob('InterviewappSocket', 'interview-websocket', 'interviewapp-socket', '')


]

jobList.each{ k ->
    serverUrl="${k.server}.${InternalDomain}"
    job("Generic${k.jobName}Deployer") {
        description("This job will deploy the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        parameters{
            stringParam('versionNum')
        }
        steps {
            shell('#!/bin/bash\n' +


                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/java-services/deploySpringbootServiceWrapper.sh $versionNum '+ "${k.artifactName} ${k.optionalArgs}"+'"\n'

            )
        }
    }

    job("GenericStop${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/java-services/stopSpringbootService.sh '+ "${k.artifactName}"+'"\n'
            )
        }
    }

    job("GenericStart${k.jobName}") {
        description("This job will start the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "/home/mettl/release/java-services/startSpringbootService.sh '+ "${k.artifactName} ${k.optionalArgs}"+'"\n'

            )
        }
    }

    job("GenericRestart${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "/home/mettl/release/java-services/stopSpringbootService.sh '+ "${k.artifactName}"+'"\n'+
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "/home/mettl/release/java-services/startSpringbootService.sh '+ "${k.artifactName} ${k.optionalArgs}"+'"\n'



            )
        }
    }
}


