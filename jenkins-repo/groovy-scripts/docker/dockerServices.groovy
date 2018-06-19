class MyJob{
    public String jobName
    public String imageName
    public String server
    public String dockerArgs
    MyJob(jobName,imageName, server, dockerArgs){
        this.jobName=jobName
        this.imageName=imageName
        this.server=server
        this.dockerArgs=dockerArgs
    }
}
def jobList = [new MyJob('IntellisenseJava', 'intellisense-java-repo', 'intellisense-java', '8095:8095')]

jobList.each { k ->
    serverUrl="${k.server}.${InternalDomain}"
    job("Generic${k.jobName}Deployer") {
        description("This job will deploy the ${k.jobName} on the target server")
        parameters {
            stringParam('versionNum')
        }
        steps {
            shell('#!/bin/bash\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/docker-services/stopDockerServices.sh " + '"\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/docker-services/deployDockerServices.sh \$versionNum ${k.imageName}"+'"\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/docker-services/startDockerServices.sh ${k.imageName} ${k.dockerArgs}" + '"\n'

            )
        }
    }

    job("GenericStop${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/docker-services/stopDockerServices.sh " + '"\n'

            )
        }
    }

    job("GenericStart${k.jobName}") {
        description("This job will start the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/docker-services/startDockerServices.sh ${k.imageName} ${k.dockerArgs}" + '"\n'

            )
        }
    }

    job("GenericRestart${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/docker-services/stopDockerServices.sh " + '"\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/docker-services/startDockerServices.sh ${k.imageName} ${k.dockerArgs}" + '"\n'

            )
        }
    }
}