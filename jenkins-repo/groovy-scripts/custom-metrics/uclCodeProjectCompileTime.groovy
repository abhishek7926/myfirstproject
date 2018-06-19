class MyJob{
    public String jobName
    public String asName

    MyJob(jobName,asName){
        this.jobName=jobName
        this.asName=asName
    }
}

def jobList = [new MyJob('UCLCompileTime', 'ucl-code-project-as')
        ]

jobList.each{ k ->

    as_grp_name="${k.asName}.${InternalDomain}"
    region="${awsRegion}"
    codeProjectId="${codeProjectIdToCompileUCLTime}"

    job("${k.jobName}") {
        description("This job will publish the UCL Code Project Time")
        triggers {
            cron("H/5 * * * *")
        }
        steps {
            shell('#!/bin/bash\n' +
"set -x\n"+
                            "Agp_all_instances=\$(aws autoscaling describe-auto-scaling-instances --region ${region} --query 'AutoScalingInstances[?AutoScalingGroupName==`${as_grp_name}`]' --output text | grep InService | grep HEALTHY | awk '{print \$4}' | head -1)\n" +
                            "healthy_ip=\$(aws ec2 describe-instances --instance-ids \$Agp_all_instances --region ${region} | grep PrivateIpAddress | awk -F \":\" '{print \$2}' | sed 's/[\",]//g' | head -n 1)\n" +
                            "healthy_ip=\$(echo \$healthy_ip | awk '{print \$1}')\n" +
                            "\n" +
                            "time_taken=\$(ssh -o StrictHostKeyChecking=no mettl@\$healthy_ip  '\n" +
                            "cd /mnt/fhgfs/codeprojects/questionCreators/${codeProjectId}/mycode\n" +
                            "START=\$(date +%s)\n" +
                            "mvn clean install >> /home/mettl/mettl_logs/mvnUcl.log\n" +
                            "END=\$(date +%s)\n" +
                            "DIFF=\$(( \$END - \$START ))\n" +
                            "echo \"It took \$DIFF seconds\"\n" +
                            "'\n" +
                            ")\n" +
                            "time_taken=\$(echo \$time_taken | awk '{print \$3}')\n" +
                            "aws cloudwatch put-metric-data --metric-name UCLTime --namespace \"custom-ec2-${ENV}\" --value \$time_taken --unit \"Seconds\" --dimensions UCLTime=metric --region ${region}"
            )
        }
    }
}
