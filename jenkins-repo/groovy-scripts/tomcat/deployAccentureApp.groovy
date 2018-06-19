jobName="Accenture"
job("Generic${jobName}Deployer") {
    description("This job will deploy the ${jobName} on the target server, make sure that you should have password " +
            'less login enabled to the target server')
    parameters{
        stringParam('versionNum')
    }
    steps {
        shell('#!/bin/bash\n' +
                'ssh -o StrictHostKeyChecking=no mettl@'+"accenture.${InternalDomain}"+ ' "release/tomcat/stopServer.sh '+
                "accenture-app-tomcat"+'"\n'+
                'ssh -o StrictHostKeyChecking=no mettl@'+"accenture.${InternalDomain}"+ ' "release/tomcat/deployAccentureApp' +
                '.sh $versionNum'+ '"\n'+
                'ssh -o StrictHostKeyChecking=no mettl@'+"accenture.${InternalDomain}"+ ' "release/tomcat/startServer.sh '+
                "accenture-app-tomcat"+'"\n'

        )
    }
}

job("GenericStop${jobName}") {
    description("This job will stop the ${jobName} on the target server, make sure that you should have password less login enabled to the target server")
    steps {
        shell('#!/bin/bash\n' +

                'ssh -o StrictHostKeyChecking=no mettl@'+"accenture.${InternalDomain}"+ ' "release/tomcat/stopServer.sh '+
                "accenture-app-tomcat"+'"\n'

        )
    }
}

job("GenericStart${jobName}") {
    description("This job will start the ${jobName} on the target server, make sure that you should have password less login enabled to the target server")
    steps {
        shell('#!/bin/bash\n' +

                'ssh -o StrictHostKeyChecking=no mettl@'+"accenture.${InternalDomain}"+ ' "release/tomcat/startServer.sh '+
                "accenture-app-tomcat"+'"\n'

        )
    }
}

job("GenericRestart${jobName}") {
    description("This job will stop the ${jobName} on the target server, make sure that you should have password less login enabled to the target server")
    steps {
        shell('#!/bin/bash\n' +

                'ssh -o StrictHostKeyChecking=no mettl@'+"accenture.${InternalDomain}"+ ' "release/tomcat/stopServer.sh '+
                "accenture-app-tomcat"+'"\n'+
                'ssh -o StrictHostKeyChecking=no mettl@'+"accenture.${InternalDomain}"+ ' "release/tomcat/startServer.sh '+
                "accenture-app-tomcat"+'"\n'

        )
    }
}
