class MyJob{
    public String jobName
    public String asName
    public String component
    public int min
    MyJob(jobName,asName,component, min){
        this.jobName=jobName
        this.asName=asName
        this.component=component
        this.min=min
    }
}


def jobList = [new MyJob('SchedulerCandidateEvent', 'scheduler-candidate-event-as', 'proctoringScheduler',"${scheduler_as_min_size}".toInteger()),
               new MyJob('Kurento-livefeed-server', 'livefeed-server-as', 'livefeed-server',"${kurento_livefeed_server_as_min_size}".toInteger()),
               new MyJob('Janus-livefeed-server', ' janus-livefeed-server-as', 'livefeed-server',"${janus_livefeed_server_as_min_size}".toInteger()),
               new MyJob('AUI', 'aui-as','aui',"${aui_as_min_size}".toInteger()),
               new MyJob('UCLCodeProject', 'ucl-code-project-as', 'userCodeLibraryCodeProject',"${uclCodeProject_as_min_size}".toInteger()),
               new MyJob('UCLCodelysis', 'ucl-codelysis-as', 'userCodeLibraryCodelysis',"${uclCodelysis_as_min_size}".toInteger()),
               new MyJob('UCLCodelysisAndroid', 'ucl-android-as', 'userCodeLibraryAndroid',"${uclCodelysisAndroid_as_min_size}".toInteger()),
               new MyJob('CodingSimulator', 'coding-simulator-as','codingSimulatorsWeb',"${codingSimulatorsWeb_as_min_size}".toInteger()),
               new MyJob('Codelysis', 'java-codelysis-as','codelysisService',"${codelysisService_as_min_size}".toInteger()),
               new MyJob('Proctoring-UI', 'proctoring-ui-as', 'proctoring-ui', "${proctoring_ui_as_min_size}".toInteger()),
               new MyJob('PR', 'partial-response-as', 'prService', "${pr_as_min_size}".toInteger()),
               new MyJob('MettlApi', 'mettl-api-as', 'mettl-apis', "${mettl_apis_as_min_size}".toInteger()),
               new MyJob('ReportUI', 'report-ui-as', 'report-ui', "${report_corporate_as_min_size}".toInteger()),
               new MyJob('ReportServiceApi', 'report-service-api-as','report-service-api',"${report_service_api_as_min_size}".toInteger()),
               new MyJob('AssessmentService', 'assessment-service-as','assessment-service-api',"${assessment_service_as_min_size}".toInteger()),
               new MyJob('MettlApiGateway', 'mettl-api-gateway-as', 'mettl-api-gateway', "${api_gateway_as_min_size}".toInteger()),
               new MyJob('RSimulatorSPI', 'r-simulator-spi-as', 'mettlspi', "${r_simulator_spi_as_min_size}".toInteger()),
               new MyJob('RSimulatorSocket', 'r-socket-as', 'socket', "${r_simulator_socket_as_min_size}".toInteger()),
               new MyJob('RSimulatorCMS', 'r-simulator-cms-as', 'R', "${r_simulator_cms_as_min_size}".toInteger()),
               new MyJob('UCLCodelysisRevert', 'ucl-codelysis-revert-as', 'userCodeLibraryCodelysis',1),
               new MyJob('QuestionService', 'question-service-as', 'question-service-impl', "${question_service_as_min_size}".toInteger()),
               new MyJob('COS', 'cos-api-as', 'cos-api', "${cos_api_as_min_size}".toInteger()),
               new MyJob('Mpaas', 'mpaas-api-as', 'mpsService', "${mpaas_api_as_min_size}".toInteger()),
               new MyJob('MeanSimulatorCMS', 'mean-simulator-cms-as', 'MEAN', "${mean_simulator_cms_as_min_size}".toInteger()),
               new MyJob('Java-MIP', 'yolo-as', 'mettlImageProcessing', "${yolo_as_min_size}".toInteger()),

]
//
//def jobList = [new MyJob('SchedulerCandidateEvent', 'scheduler-candidate-event-as', 'proctoringScheduler',"${scheduler_as_min_size}".toInteger())
//
//
//]

jobList.each{ k ->

    as_grp_name="${k.asName}.${InternalDomain}"
    region="${awsRegion}"
    component="${k.component}"

    job("Generic${k.jobName}Deployer") {
        description("This job will deploy the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        parameters{
            stringParam('versionNum')
        }
        steps {
            shell('#!/bin/bash\n' +

                    "echo \"Setting autoscale group ${as_grp_name}\"\n" +
                    "aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${as_grp_name} --desired-capacity 0  --min-size 0 --region ${region}\n" +
                    "echo \$versionNum > index.html\n" +
                    "aws s3 mv ./index.html s3://deployement-versions/${ENV}/${component}/index.html --region ap-south-1\n" +
                    "sleep 40\n" +
                    "aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${as_grp_name} --desired-capacity ${k.min}  --min-size ${k.min} --region ${region}\n" +
                    "echo \"New machine group initiated\""
            )
        }
    }

    job("GenericStop${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    "echo \"Setting autoscale group ${as_grp_name}\"\n" +
                    "aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${as_grp_name} --desired-capacity 0  --min-size 0 --region ${region}\n" +
                    "sleep 40\n"

            )
        }
    }

    job("GenericStart${k.jobName}") {
        description("This job will start the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    "aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${as_grp_name} --desired-capacity ${k.min}  --min-size ${k.min} --region ${region}\n"

            )
        }
    }

    job("GenericRestart${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    "echo \"Setting autoscale group ${as_grp_name}\"\n" +
                    "aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${as_grp_name} --desired-capacity 0  --min-size 0 --region ${region}\n" +
                    "sleep 40\n" +
                    "aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${as_grp_name} --desired-capacity ${k.min}  --min-size ${k.min} --region ${region}\n" +
                    "echo \"New machine group initiated\""

            )
        }
    }
}
