class MyJob{
  public String jobName
  public String asName
  public String min
  public String lbName
  public String component

  MyJob(jobName,asName,min,component,lbName){
    this.jobName=jobName
    this.asName=asName
    this.min=min
    this.component=component
    this.lbName=lbName

  }
}

def jobList = [
//               new MyJob('Kurento-livefeed-server', 'livefeed-server-as',"${kurento_livefeed_server_as_min_size}".toInteger(),'livefeed-server','livefeed-server-lb'),
//               new MyJob('AUI', 'aui-as','aui',"${aui_as_min_size}".toInteger(),'aui-lb'),
//               new MyJob('UCLCodeProject', 'ucl-code-project-as',"${uclCodeProject_as_min_size}".toInteger(),'uclCodeProject', 'ucl-code-project-lb'),
//               new MyJob('UCLCodelysis', 'ucl-codelysis-as',"${uclCodelysis_as_min_size}".toInteger(),'uclCodelysis', 'ucl-codelysis-lb',),
//               new MyJob('UCLCodelysisAndroid', 'ucl-android-as',"${uclCodelysisAndroid_as_min_size}".toInteger(), 'uclCodelysisAndroid', 'ucl-android-lb'),
//               new MyJob('CodingSimulator', 'coding-simulator-as',"${codingSimulatorsWeb_as_min_size}".toInteger(),'codingSimulatorsWeb', 'coding-simulator-lb'),
//               new MyJob('Codelysis', 'java-codelysis-as',"${codelysisService_as_min_size}".toInteger(),'codelysisService','java-codelysis-lb'),
//               new MyJob('Proctoring-UI', 'proctoring-ui-as',"${proctoring_ui_as_min_size}".toInteger(), 'proctoring-ui', 'proctoring-ui-lb'),
//               new MyJob('PR', 'partial-response-as',"${pr_as_min_size}".toInteger(), 'prService', 'partial-response-lb'),
//               new MyJob('MettlApi', 'mettl-api-as',"${mettl_apis_as_min_size}".toInteger(), 'mettl-apis', 'mettl-api-lb'),
//               new MyJob('ReportUI', 'report-ui-as',"${report_corporate_as_min_size}".toInteger(), 'report-ui', 'report-ui-lb'),
//               new MyJob('ReportServiceApi', 'report-service-api-as',"${report_service_api_as_min_size}".toInteger(), 'report-service-api', 'report-service-api-lb'),
//               new MyJob('AssessmentService', 'assessment-service-as',"${assessment_service_as_min_size}".toInteger(), 'assessment-service-api', 'assessment-service-lb')


]

jobList.each{ k ->

  as_grp_name="${k.asName}.${InternalDomain}"
  load_balancer_name="${k.lbName}-${InternalDomain}"
  region="${awsRegion}"
  min="${k.min}"
  component="${k.component}"

  job("Generic${k.jobName}Deployer") {
    description("This job will deploy the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
    parameters{
      stringParam('versionNum')
    }
    steps {
      shell('#!/bin/bash\n' +

              "echo \$versionNum > index.html\n" +
              "aws s3 mv ./index.html s3://deployement-versions/${ENV}/${component}/index.html --region ap-south-1\n" +
              "elb_total_instances=`aws elb describe-load-balancers --load-balancer-name ${load_balancer_name} --region ap-south-1 | grep InstanceId | wc -l`\n" +
              "elb_healthy_instances=`aws elb describe-instance-health --load-balancer-name ${load_balancer_name} --region ap-south-1 | grep State | awk '{print \$2}' | sed 's#\"##g' | grep -wi InService | wc -l`\n" +
              "if [ \"\$elb_total_instances\"  == \"\$elb_healthy_instances\" ]; then\n" +
              "aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${as_grp_name} --termination-policies \"OldestInstance\" --region ${region}\n" +
              "      termination_policy=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names ${as_grp_name} --region ${region} | grep -A 1 TerminationPolicies | tail -1 | sed 's#\"##g'`\n" +
              "      termination_policy=`echo \$termination_policy`\n" +
              "      if [ \"\$termination_policy\" == \"OldestInstance\" ]; then\n" +
              "      echo \"Termination Policy set to \$termination_policy so we can deploy nw\"\n" +
              "      pre_deploy_desired=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names ${as_grp_name} --region ${region} | grep DesiredCapacity | awk '{print \$2}' | sed 's#,##g'`\n" +
              "      pre_deploy_max_size=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names ${as_grp_name} --region ${region} | grep MaxSize | awk '{print \$2}' | sed 's#,##g'`\n" +
              "      set_desired_to=\$(( \$pre_deploy_desired * 2 ))\n" +
              "              echo \"Setting desired capacity to \$set_desired_to\"\n" +
              "      if [ \$set_desired_to -gt \$pre_deploy_max_size ]; then\n" +
              "      echo \"Have to increase max size as requested desired capacity \$set_desired_to is greater than current max size \$pre_deploy_max_size\"\n" +
              "      revert_max_size=\"yes\"\n" +
              "      aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${as_grp_name} --max-size \$set_desired_to --region ${region}\n" +
              "      else\n" +
              "      revert_max_size=\"no\"\n" +
              "      fi\n" +
              "              aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${as_grp_name} --desired-capacity \$set_desired_to --region ${region}\n" +
              "      healthy_in_lb=`aws elb describe-instance-health --load-balancer-name ${load_balancer_name} --region ${region} | grep State | awk '{print \$2}' | sed 's#\"##g' | grep -wi InService | wc -l`\n" +
              "      aws autoscaling suspend-processes --auto-scaling-group-name ${as_grp_name} --scaling-processes Terminate --region ${region}\n" +

              "      until [ \$set_desired_to -eq \$healthy_in_lb ]; do\n" +
              "      echo \"sleeping for 5 sec as all instances in load balancer are not healthy\"\n" +
              "              sleep 5\n" +
              "              healthy_in_lb=`aws elb describe-instance-health --load-balancer-name ${load_balancer_name} --region ${region} | grep State | awk '{print \$2}' | sed 's#\"##g' | grep -wi InService | wc -l`\n" +
              "      done\n" +
              "      aws autoscaling resume-processes --auto-scaling-group-name ${as_grp_name} --scaling-processes Terminate --region ${region}\n" +
              "      echo \"all instances in load balancer are healthy.Downscaling to actual desired size and preventing to launch more instances\"\n" +
              "      aws autoscaling suspend-processes --auto-scaling-group-name ${as_grp_name} --scaling-processes Launch --region ${region}\n" +
              "      aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${as_grp_name} --desired-capacity \$pre_deploy_desired --region ${region}\n" +
              "      post_deploy_desired=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names ${as_grp_name} --region ${region} | grep DesiredCapacity | awk '{print \$2}' | sed 's#,##g'`\n" +
              "      until [ \$post_deploy_desired -eq \$pre_deploy_desired ]; do\n" +
              "      echo \"sleeping for 5 sec as older instances are terminating\"\n" +
              "              sleep 5\n" +
              "              post_deploy_desired=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names ${as_grp_name} --region ${region} | grep DesiredCapacity | awk '{print \$2}' | sed 's#,##g'`\n" +
              "      done\n" +
              "      aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${as_grp_name} --termination-policies \"Default\" --region ${region}\n" +
              "      if [ \$revert_max_size == \"yes\" ]; then\n" +
              "      echo \"reverting max size also\"\n" +
              "      aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${as_grp_name} --max-size \$pre_deploy_max_size --region ${region}\n" +
              "\n" +
              "\n" +
              "      elif [ \$revert_max_size == \"no\" ]; then\n" +
              "      echo \"no need to revert as max size\"\n" +
              "      fi\n" +
              "              post_deploy_desired=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names ${as_grp_name} --region ${region} | grep DesiredCapacity | awk '{print \$2}' | sed 's#,##g'`\n" +
              "      if [ \"\$post_deploy_desired\" == \"\$pre_deploy_desired\" ]; then\n" +
              "      echo \"auto scaling grp is up with new deployement version and with same no. of desired instances prior to deployement process\"\n" +
              "      echo \"resuming all suspended process in autoscaling grp\"\n" +
              "      aws autoscaling resume-processes --auto-scaling-group-name ${as_grp_name} --scaling-processes Launch --region ${region}\n" +
              "      fi\n" +
              "      else\n" +
              "      echo \"Termination policy is \$termination_policy \"\n" +
              "\n" +
              "\n" +
              "      fi\n" +

              "      else\n" +
              "      echo \"All elb instances are not healthy\"\n" +
            "exit 1\n" +

              "fi"

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