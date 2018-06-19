class MyJob{
    public String jobName
    public String artifactName
    public String server
    public String pythonArgs
    public String textToSearchToStopService
    MyJob(jobName,artifactName, server, pythonArgs, textToSearchToStopService){
        this.jobName=jobName
        this.artifactName=artifactName
        this.server=server
        this.pythonArgs=pythonArgs
        this.textToSearchToStopService=textToSearchToStopService
    }
}
def jobList = [new MyJob('CSharpIntellisense', 'csharp-intellisense', 'intellisense-csharp', '', '')]

jobList.each { k ->
    serverUrl="${k.server}.${InternalDomain}"
    job("Generic${k.jobName}Deployer") {
        description("This job will deploy the ${k.jobName} on the target server")
        parameters {
            stringParam('versionNum')
        }
        steps {
            shell('#!/bin/bash\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/misc/deployMettlZipComponent.sh \$versionNum ${k.artifactName}"+'"\n'

            )
        }
    }
}