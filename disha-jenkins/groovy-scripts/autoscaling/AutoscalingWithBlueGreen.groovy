class MyJob{
    public String jobName
    public String asName
    public String component
    public int min
    public String disha_component
    public String load_balancer_name
    public int multiply_desired
    MyJob(jobName,asName,component, min, disha_component, load_balancer_name, multiply_desired){
        this.jobName=jobName
        this.asName=asName
        this.component=component
        this.min=min
        this.disha_component=disha_component
        this.load_balancer_name=load_balancer_name
        this.multiply_desired=multiply_desired
    }
}

def jobList = [new MyJob('DishaWeb', 'web', 'disha-web', "${disha_web_as_min_size}".toInteger(), 'app', 'pmgdisha-lb', 2),
               new MyJob('DishaCms', 'cms', 'disha-cms', "${disha_cms_as_min_size}".toInteger(), 'cms', 'pmgdisha-lb', 2),
]

jobList.each{ k ->

    as_grp_name="${ENV}-${k.asName}"
    region="${awsRegion}"
    component="${k.component}"
    load_balancer_name="${ENV}-${k.load_balancer_name}"
    disha_component="${k.disha_component}"
    multiply_desired="${k.multiply_desired}"

    job("Generic${k.jobName}Deployer") {
        description("This job will deploy the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        parameters{
            stringParam('versionNum')
        }
        steps {
            shell('#!/bin/bash \n'+
                    'as_grp_name='+"$as_grp_name"+'\n' +
                    'region='+"$region"+'\n' +
                    'multiply_desired='+"$multiply_desired"+'\n' +
                    'load_balancer_name='+"$load_balancer_name"+'\n' +
                    'disha_component='+"$disha_component"+'\n' +
                    'echo $versionNum > index.html\n'+
                    'aws s3 mv ./index.html s3://'+"${ENV}-deployement-versions/${ENV}/${component}"+'/index.html --region ap-south-1\n'+
                    'load_balancer_arn=`aws elbv2 describe-load-balancers --names $load_balancer_name --region $region | grep LoadBalancerArn | awk \'{print $2}\' | sed \'s#"##g\' | sed \'s#,##g\'`\n' +
                    'if [ "$disha_component" == "app" ]; then\n' +
                    'target_group_arn=`aws elbv2 describe-target-groups --load-balancer-arn $load_balancer_arn --region $region | grep TargetGroupArn | grep -i HTTPS | awk \'{print $2}\' |  sed \'s#"##g\' |  sed \'s#,##g\' | grep -w app-https`\n' +
                    'elif [ "$disha_component" == "cms" ]; then\n' +
                    'target_group_arn=`aws elbv2 describe-target-groups --load-balancer-arn $load_balancer_arn --region $region | grep TargetGroupArn | grep -i HTTPS | awk \'{print $2}\' |  sed \'s#"##g\' |  sed \'s#,##g\' | grep cms-https`\n' +
                    'fi\n' +
                    'aws autoscaling update-auto-scaling-group --auto-scaling-group-name $as_grp_name --termination-policies "OldestInstance" --region $region\n' +
                    'termination_policy=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $as_grp_name --region $region | grep -A 1 TerminationPolicies | tail -1 | sed \'s#"##g\'`\n' +
                    'termination_policy=`echo $termination_policy`\n' +
                    'if [ "$termination_policy" == "OldestInstance" ]; then\n' +
                    'echo "Termination Policy set to $termination_policy so we can deploy nw"\n' +
                    'pre_deploy_desired=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $as_grp_name --region $region | grep DesiredCapacity | awk \'{print $2}\' | sed \'s#,##g\'`\n' +
                    'pre_deploy_max_size=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $as_grp_name --region $region | grep MaxSize | awk \'{print $2}\' | sed \'s#,##g\'`\n' +
                    'set_desired_to=$(( $pre_deploy_desired * $multiply_desired ))\n' +
                    'echo "Setting desired capacity to $set_desired_to"\n' +
                    'if [ $set_desired_to -gt $pre_deploy_max_size ]; then\n' +
                    'echo "Have to increase max size as requested desired capacity $set_desired_to is greater than current max size $pre_deploy_max_size"\n' +
                    'revert_max_size="yes"\n' +
                    'aws autoscaling update-auto-scaling-group --auto-scaling-group-name $as_grp_name --max-size $set_desired_to --region $region\n' +
                    'else\n' +
                    'revert_max_size="no"\n' +
                    'fi\n' +
                    'aws autoscaling update-auto-scaling-group --auto-scaling-group-name $as_grp_name --desired-capacity $set_desired_to --region $region\n' +
                    'healthy_in_lb=`aws elbv2 describe-target-health --target-group-arn $target_group_arn --region $region | grep State | awk \'{print $2}\' | sed \'s#"##g\' | grep -wi healthy | wc -l`\n' +
                    'until [ $set_desired_to -eq $healthy_in_lb ]; do \n' +
                    'echo "sleeping for 5 sec as all instances in load balancer are not healthy"\n' +
                    'sleep 5\n' +
                    'healthy_in_lb=`aws elbv2 describe-target-health --target-group-arn $target_group_arn --region $region | grep State | awk \'{print $2}\' | sed \'s#"##g\' | grep -wi healthy | wc -l`\n' +
                    'done\n' +
                    'echo "all instances in load balancer are healthy.Downscaling to actual desired size and preventing to launch more instances"\n' +
                    'aws autoscaling update-auto-scaling-group --auto-scaling-group-name $as_grp_name --desired-capacity $pre_deploy_desired --region $region\n' +
                    '\n' +
                    'current_as_size=$(aws autoscaling describe-auto-scaling-instances --region $region --query \'AutoScalingInstances[?AutoScalingGroupName==`\'$as_grp_name\'`]\' --output text | grep InService |  wc -l)\n' +
                    'until [ $current_as_size -eq $pre_deploy_desired ]; do\n' +
                    'echo $current_as_size\n' +
                    'echo $pre_deploy_desired\n' +
                    'echo "waiting till instances get terminated with termination policy as OLdestInstance"\n' +
                    'current_as_size=$(aws autoscaling describe-auto-scaling-instances --region $region --query \'AutoScalingInstances[?AutoScalingGroupName==`\'$as_grp_name\'`]\' --output text | grep InService |  wc -l)\n' +
                    'sleep 5\n' +
                    'done\n' +
                    '\n' +
                    '\n' +
                    '\n' +
                    'aws autoscaling update-auto-scaling-group --auto-scaling-group-name $as_grp_name --termination-policies "Default" --region $region\n' +
                    'if [ $revert_max_size == "yes" ]; then\n' +
                    'echo "reverting max size also"\n' +
                    'aws autoscaling update-auto-scaling-group --auto-scaling-group-name $as_grp_name --max-size $pre_deploy_max_size --region $region\n' +
                    '\n' +
                    '\n' +
                    'elif [ $revert_max_size == "no" ]; then\n' +
                    'echo "no need to revert as max size"\n' +
                    'fi\n' +
                    'else\n' +
                    'echo "Termination policy is $termination_policy "\n' +
                    'fi'
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
                    'as_grp_name='+"$as_grp_name"+'\n' +
                    'region='+"$region"+'\n' +
                    'multiply_desired='+"$multiply_desired"+'\n' +
                    'load_balancer_name='+"$load_balancer_name"+'\n' +
                    'disha_component='+"$disha_component"+'\n' +
                    'load_balancer_arn=`aws elbv2 describe-load-balancers --names $load_balancer_name --region $region | grep LoadBalancerArn | awk \'{print $2}\' | sed \'s#"##g\' | sed \'s#,##g\'`\n' +
                    'if [ "$disha_component" == "app" ]; then\n' +
                    'target_group_arn=`aws elbv2 describe-target-groups --load-balancer-arn $load_balancer_arn --region $region | grep TargetGroupArn | grep -i HTTPS | awk \'{print $2}\' |  sed \'s#"##g\' |  sed \'s#,##g\' | grep -w app-https`\n' +
                    'elif [ "$disha_component" == "cms" ]; then\n' +
                    'target_group_arn=`aws elbv2 describe-target-groups --load-balancer-arn $load_balancer_arn --region $region | grep TargetGroupArn | grep -i HTTPS | awk \'{print $2}\' |  sed \'s#"##g\' |  sed \'s#,##g\' | grep cms-https`\n' +
                    'fi\n' +
                    'aws autoscaling update-auto-scaling-group --auto-scaling-group-name $as_grp_name --termination-policies "OldestInstance" --region $region\n' +
                    'termination_policy=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $as_grp_name --region $region | grep -A 1 TerminationPolicies | tail -1 | sed \'s#"##g\'`\n' +
                    'termination_policy=`echo $termination_policy`\n' +
                    'if [ "$termination_policy" == "OldestInstance" ]; then\n' +
                    'echo "Termination Policy set to $termination_policy so we can deploy nw"\n' +
                    'pre_deploy_desired=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $as_grp_name --region $region | grep DesiredCapacity | awk \'{print $2}\' | sed \'s#,##g\'`\n' +
                    'pre_deploy_max_size=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $as_grp_name --region $region | grep MaxSize | awk \'{print $2}\' | sed \'s#,##g\'`\n' +
                    'set_desired_to=$(( $pre_deploy_desired * $multiply_desired ))\n' +
                    'echo "Setting desired capacity to $set_desired_to"\n' +
                    'if [ $set_desired_to -gt $pre_deploy_max_size ]; then\n' +
                    'echo "Have to increase max size as requested desired capacity $set_desired_to is greater than current max size $pre_deploy_max_size"\n' +
                    'revert_max_size="yes"\n' +
                    'aws autoscaling update-auto-scaling-group --auto-scaling-group-name $as_grp_name --max-size $set_desired_to --region $region\n' +
                    'else\n' +
                    'revert_max_size="no"\n' +
                    'fi\n' +
                    'aws autoscaling update-auto-scaling-group --auto-scaling-group-name $as_grp_name --desired-capacity $set_desired_to --region $region\n' +
                    'healthy_in_lb=`aws elbv2 describe-target-health --target-group-arn $target_group_arn --region $region | grep State | awk \'{print $2}\' | sed \'s#"##g\' | grep -wi healthy | wc -l`\n' +
                    'until [ $set_desired_to -eq $healthy_in_lb ]; do \n' +
                    'echo "sleeping for 5 sec as all instances in load balancer are not healthy"\n' +
                    'sleep 5\n' +
                    'healthy_in_lb=`aws elbv2 describe-target-health --target-group-arn $target_group_arn --region $region | grep State | awk \'{print $2}\' | sed \'s#"##g\' | grep -wi healthy | wc -l`\n' +
                    'done\n' +
                    'echo "all instances in load balancer are healthy.Downscaling to actual desired size and preventing to launch more instances"\n' +
                    'aws autoscaling update-auto-scaling-group --auto-scaling-group-name $as_grp_name --desired-capacity $pre_deploy_desired --region $region\n' +
                    '\n' +
                    'current_as_size=$(aws autoscaling describe-auto-scaling-instances --region $region --query \'AutoScalingInstances[?AutoScalingGroupName==`\'$as_grp_name\'`]\' --output text | grep InService |  wc -l)\n' +
                    'until [ $current_as_size -eq $pre_deploy_desired ]; do\n' +
                    'echo $current_as_size\n' +
                    'echo $pre_deploy_desired\n' +
                    'echo "waiting till instances get terminated with termination policy as OLdestInstance"\n' +
                    'current_as_size=$(aws autoscaling describe-auto-scaling-instances --region $region --query \'AutoScalingInstances[?AutoScalingGroupName==`\'$as_grp_name\'`]\' --output text | grep InService |  wc -l)\n' +
                    'sleep 5\n' +
                    'done\n' +
                    '\n' +
                    '\n' +
                    '\n' +
                    'aws autoscaling update-auto-scaling-group --auto-scaling-group-name $as_grp_name --termination-policies "Default" --region $region\n' +
                    'if [ $revert_max_size == "yes" ]; then\n' +
                    'echo "reverting max size also"\n' +
                    'aws autoscaling update-auto-scaling-group --auto-scaling-group-name $as_grp_name --max-size $pre_deploy_max_size --region $region\n' +
                    '\n' +
                    '\n' +
                    'elif [ $revert_max_size == "no" ]; then\n' +
                    'echo "no need to revert as max size"\n' +
                    'fi\n' +
                    'else\n' +
                    'echo "Termination policy is $termination_policy "\n' +
                    'fi'

            )
        }
    }
}