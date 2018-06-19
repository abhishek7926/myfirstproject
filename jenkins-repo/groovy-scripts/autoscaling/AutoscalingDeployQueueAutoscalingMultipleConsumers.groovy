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

def jobList = [
        new MyJob('ApplicationGrader', 'application-grader-as', 'application-grader',"${application_grader_as_min_size}".toInteger()),

        new MyJob('EmailService', 'email-service-as', 'mettl-email-service',"${email_service_as_min_size}".toInteger())


]

jobList.each{ k ->

    as_grp_name="${k.asName}.${InternalDomain}"
    region="${awsRegion}"
    component="${k.component}"

    job("Generic${k.jobName}Deployer") {
        description("This job will deploy the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        parameters{
            stringParam('versionNum')
            stringParam('consumers', '5')
        }
        steps {
            shell('#!/bin/bash\n' +

                    "echo \"Setting autoscale group ${as_grp_name}\"\n" +
                    "aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${as_grp_name} --desired-capacity 0  --min-size 0 --region ${region}\n" +
                    "echo \$versionNum > index.html\n" +
                    "aws s3 mv ./index.html s3://deployement-versions/${ENV}/${component}/index.html --region ap-south-1\n" +
                    "echo \$consumers > ${component}-consumers.html\n" +
                    "aws s3 mv ./${component}-consumers.html s3://deployement-versions/${ENV}/${component}/${component}-consumers.html --region ap-south-1\n" +
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
