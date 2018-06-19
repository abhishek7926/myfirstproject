serverUrl="htmltopdf.${InternalDomain}"
jobName = "HtmlToPdfService"
job("Generic${jobName}Deployer") {
    description("This job will deploy the HtmlToPdfService on the target server")
    parameters{
        stringParam('versionNum')
    }
    steps {
        shell('#!/bin/bash\n' +
                'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ " \"release/misc/deployMettlZipComponent.sh \$versionNum htmlToPdfService"+'"\n' +
                'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ " \"release/misc/stopNodeJsService.sh htmlToPdfService"+'"\n' +
                'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ " \"release/misc/startHtmlToPdfService.sh"+'"\n'


        )
    }
}
job("GenericStop${jobName}") {
    description("This job will stop the ${jobName} on the target server, make sure that you should have password less login enabled to the target server")
    steps {
        shell('#!/bin/bash\n' +

                'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ " \"release/misc/stopNodeJsService.sh htmlToPdfService"+'"\n'

        )
    }
}

job("GenericStart${jobName}") {
    description("This job will start the ${jobName} on the target server, make sure that you should have password less login enabled to the target server")
    steps {
        shell('#!/bin/bash\n' +

                'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ " \"release/misc/startHtmlToPdfService.sh"+'"\n'

        )
    }
}

job("GenericRestart${jobName}") {
    description("This job will stop the ${jobName} on the target server, make sure that you should have password less login enabled to the target server")
    steps {
        shell('#!/bin/bash\n' +

                'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ " \"release/misc/stopNodeJsService.sh htmlToPdfService"+'"\n' +
                'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ " \"release/misc/startHtmlToPdfService.sh"+'"\n'

        )
    }
}