class MyJob{
    public String jobName
    public String artifactName
    public String server
    public String optionalArgumentList
    MyJob(jobName, artifactName, server, optionalArgumentList){
        this.jobName=jobName
        this.artifactName=artifactName
        this.server=server
        this.optionalArgumentList=optionalArgumentList
    }
}
def jobList = [new MyJob('ExcelService', 'excelService', 'excel', 'excelRequest itemAnalysisExcel'),
               new MyJob('LargeExcelService', 'excelService', 'large-excel', 'largeExcelRequest largeInferentialExcelRequest combinedExcelRequest'),
               new MyJob('Scheduler', 'scheduler', 'scheduler', 'runscheduledtasks accountActivity manageEnterpriseBillingAmount scheduler testNotification startcandidateassessment'),
]
jobList.each{ k ->
    serverUrl="${k.server}.${InternalDomain}"
    job("Generic${k.jobName}Deployer") {
        description("This job will deploy the ${k.jobName} on the target server")
        parameters{
            stringParam('versionNum')
        }
        steps {
            shell('#!/bin/bash\n' +
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ " \"release/java-services/deployMultipleInstanceJavaServiceWrapper.sh \$versionNum ${k.artifactName} '${k.optionalArgumentList}'"+'"\n'

            )
        }
    }


    job("GenericStop${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ " \"release/java-services/stopMultipleInstanceJavaService.sh ${k.artifactName} '${k.optionalArgumentList}'"+'"\n'

            )
        }
    }

    job("GenericStart${k.jobName}") {
        description("This job will start the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ " \"release/java-services/startMultipleInstanceJavaService.sh ${k.artifactName} '${k.optionalArgumentList}'"+'"\n'

            )
        }
    }

    job("GenericRestart${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ " \"release/java-services/stopMultipleInstanceJavaService.sh ${k.artifactName} '${k.optionalArgumentList}'"+'"\n'+
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ " \"release/java-services/startMultipleInstanceJavaService.sh ${k.artifactName} '${k.optionalArgumentList}'"+'"\n'

            )
        }
    }
}