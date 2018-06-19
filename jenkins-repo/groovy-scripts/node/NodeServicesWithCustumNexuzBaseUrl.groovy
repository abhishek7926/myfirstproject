class MyJob {
    public String jobName
    public String artifactName
    public String BASE_NEXUS_URL
    public String server
    public String scriptName

    MyJob(jobName, artifactName, BASE_NEXUS_URL, server, scriptName) {
        this.jobName = jobName
        this.artifactName = artifactName
        this.BASE_NEXUS_URL = BASE_NEXUS_URL
        this.server = server
        this.scriptName = scriptName
    }
}

def jobList = [new MyJob('MeanSimulatorRouter', 'meanRouter', 'releases/com/mettl/simulators/', 'mean-simulator-router', 'app.js')
]

jobList.each { k ->
    serverUrl = "${k.server}.${InternalDomain}"
    job("Generic${k.jobName}Deployer") {
        description("This job will deploy the ${k.jobName} on the target server")
        parameters {
            stringParam('versionNum')
        }
        steps {
            shell('#!/bin/bash\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/node-services/foreverStop.sh ${k.scriptName}" + '"\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/misc/deployMettlZipComponentWithCustumBaseNexsusUrl.sh \$versionNum ${k.artifactName} ${k.BASE_NEXUS_URL}" + '"\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/node-services/startRServerNodeClient.sh ${k.artifactName} ${k.scriptName}" + '"\n'
            )
        }
    }

    job("GenericStop${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/node-services/foreverStop.sh ${k.scriptName}" + '"\n'

            )
        }
    }

    job("GenericStart${k.jobName}") {
        description("This job will start the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/node-services/startRServerNodeClient.sh ${k.artifactName} ${k.scriptName}" + '"\n'

            )
        }
    }

    job("GenericRestart${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/node-services/foreverStop.sh ${k.scriptName}" + '"\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/node-services/startRServerNodeClient.sh ${k.artifactName} ${k.scriptName}" + '"\n'

            )
        }
    }
}