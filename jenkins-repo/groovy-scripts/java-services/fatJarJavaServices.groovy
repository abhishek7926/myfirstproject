class MyJob{
    public String jobName
    public String artifactName
    public String server
    public String base_nexus_url
    public String startCommand
    MyJob(jobName,artifactName, server, base_nexus_url, startCommand){
        this.jobName=jobName
        this.artifactName=artifactName
        this.server=server
        this.base_nexus_url=base_nexus_url
        this.startCommand=startCommand
    }
}
def jobList = [
//        new MyJob('InterviewappAdminAPI22', 'admin-api', 'mongo_client_archival', 'releases/com/mettl/', 'java -jar -Dserver.port=8084 admin-api.jar'),

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
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "/home/mettl/release/java-services/genericDeployFatJarWrapper.sh $versionNum '+ "${k.artifactName} ${k.base_nexus_url} ${k.startCommand}"+'"\n'

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
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "/home/mettl/release/java-services/placeholderStartJavaService.sh '+ "${k.artifactName} '${k.startCommand}'"+'"\n'

            )
        }
    }

    job("GenericRestart${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "/home/mettl/release/java-services/stopSpringbootService.sh '+ "${k.artifactName}"+'"\n'+
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "/home/mettl/release/java-services/placeholderStartJavaService.sh '+ "${k.artifactName} '${k.startCommand}'"+'"\n'



            )
        }
    }
}