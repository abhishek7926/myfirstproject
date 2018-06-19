class MyJob{
    public String jobName
    public String artifactName
    public String server
    MyJob(jobName,artifactName, server){
        this.jobName=jobName
        this.artifactName=artifactName
        this.server=server
    }
}
def jobList = [
               new MyJob('SkillMaster-admin', 'skillmaster', 'skill-master-admin'),
	       new MyJob('SkillMaster-special', 'skillmaster', 'skill-master-special'),
	       new MyJob('SkillMaster-general', 'skillmaster', 'skill-master-general'),
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


                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/java-services/deployMettlJavaServiceWithoutHardKillWrapper.sh $versionNum '+ "${k.artifactName}"+'"\n'

            )
        }
    }

    job("GenericStop${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "/home/mettl/release/java-services/stopJavaServiceWithoutHardKill.sh '+ "${k.artifactName}"+'"\n'
            )
        }
    }

    job("GenericStart${k.jobName}") {
        description("This job will start the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "/home/mettl/release/java-services/startJavaService.sh '+ "${k.artifactName}"+'"\n'

            )
        }
    }

    job("GenericRestart${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "/home/mettl/release/java-services/stopJavaServiceWithoutHardKill.sh '+ "${k.artifactName}"+'"\n'+
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "/home/mettl/release/java-services/startJavaService.sh '+ "${k.artifactName}"+'"\n'



            )
        }
    }
}
