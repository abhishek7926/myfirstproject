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
def jobList = [new MyJob('PythonIntellisense', 'python-intellisense', 'intellisense-python', '\'jpython.py --host 0.0.0.0 --port 3000\'', 'jpython.py')]

jobList.each { k ->
    serverUrl="${k.server}.${InternalDomain}"
    job("Generic${k.jobName}Deployer") {
        description("This job will deploy the ${k.jobName} on the target server")
        parameters {
            stringParam('versionNum')
        }
        steps {
            shell('#!/bin/bash\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/python-services/stopPythonService.sh ${k.textToSearchToStopService}" + '"\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/misc/deployMettlZipComponent.sh \$versionNum ${k.artifactName}"+'"\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/python-services/startPythonService.sh ${k.artifactName} ${k.pythonArgs}" + '"\n'


            )
        }
    }

    job("GenericStop${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/python-services/stopPythonService.sh ${k.textToSearchToStopService}" + '"\n'

            )
        }
    }

    job("GenericStart${k.jobName}") {
        description("This job will start the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/python-services/startPythonService.sh ${k.artifactName} ${k.pythonArgs}" + '"\n'

            )
        }
    }

    job("GenericRestart${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/python-services/stopPythonService.sh ${k.textToSearchToStopService}" + '"\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@' + "${serverUrl}" + " \"release/python-services/startPythonService.sh ${k.artifactName} ${k.pythonArgs}" + '"\n'

            )
        }
    }
}