class MyJob{
    public String jobName
    public String artifactName
    public String server
    public String scriptName
    MyJob(jobName,artifactName, server, scriptName){
        this.jobName=jobName
        this.artifactName=artifactName
        this.server=server
        this.scriptName=scriptName
    }
}
def jobList = [new MyJob('INTELLISENSE_ROUTER', 'intellisense-router', 'intellisense-router', 'index.js')]

jobList.each { k ->
    serverUrl="${k.server}.${InternalDomain}"
    job("Generic${k.jobName}Deployer") {
        description("This job will deploy the ${k.jobName} on the target server")
        parameters {
            stringParam('versionNum')
        }
        steps {
            shell('#!/bin/bash\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/node-services/foreverStop.sh ${k.scriptName}"+'"\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/misc/deployMettlZipComponent.sh \$versionNum ${k.artifactName}"+'"\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/node-services/foreverStart.sh ${k.artifactName} ${k.scriptName}"+'"\n'
            )
        }
    }
}