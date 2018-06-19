class MyJob{
    public String jobName
    public String artifactName
    public String server
    public String baseNexusUrl
    public String pre_argument
    MyJob(jobName,artifactName, server, baseNexusUrl, pre_argument){
        this.jobName=jobName
        this.artifactName=artifactName
        this.server=server
        this.baseNexusUrl=baseNexusUrl
        this.pre_argument=pre_argument
    }
}
def jobList = [
        new MyJob('RSimulatorRouter', 'router', 'r-simulators-router', 'releases/com/mettl/simulators/', '' ),
        new MyJob('MeanSimulatorGateway', 'gateway-service', 'mean-simulator-gateway', 'releases/com/mettl/', '' ),

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


                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/java-services/deployRSimulatorsServices.sh $versionNum '+ "${k.artifactName} ${k.baseNexusUrl} ${k.pre_argument}"+'"\n'

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
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "/home/mettl/release/java-services/startRSimulatorsServices.sh '+ "${k.artifactName} ${k.pre_argument}"+'"\n'

            )
        }
    }

    job("GenericRestart${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "/home/mettl/release/java-services/stopSpringbootService.sh '+ "${k.artifactName}"+'"\n'+
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "/home/mettl/release/java-services/startRSimulatorsServices.sh '+ "${k.artifactName} ${k.pre_argument}"+'"\n'



            )
        }
    }
}


