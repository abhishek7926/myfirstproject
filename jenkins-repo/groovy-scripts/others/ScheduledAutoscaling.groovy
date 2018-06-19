class MyJob{
    public String jobName
    public String as_name
    public String triggerTime
    public String autoscalingMinSize
    public String schdeuleAutoscaling
    MyJob(jobName,as_name,triggerTime,autoscalingMinSize,schdeuleAutoscaling){
        this.jobName=jobName
        this.as_name=as_name
        this.triggerTime=triggerTime
        this.autoscalingMinSize=autoscalingMinSize
        this.schdeuleAutoscaling=schdeuleAutoscaling
    }
}

def jobList = [new MyJob('Scheduled-MIP-Upscaling','mip','0 8 * * *',4,"${schedule_mip_autoscaling}"),
               new MyJob('Scheduled-MIP-Downscaling','mip','0 20 * * *',1,"${schedule_mip_autoscaling}"),
               new MyJob('Scheduled-UCL-Codelysis-Upscaling','ucl-codelysis','0 8 * * *',5,"${schedule_ucl_codelysis_autoscaling}"),
               new MyJob('Scheduled-UCL-Codelysis-Downscaling','ucl-codelysis','0 22 * * *',2,"${schedule_ucl_codelysis_autoscaling}"),
               new MyJob('Scheduled-Java-Codelysis-Upscaling','java-codelysis','0 8 * * *',2,"${schedule_java_codelysis_autoscaling}"),
               new MyJob('Scheduled-Java-Codelysis-Downscaling','java-codelysis','0 22 * * *',1,"${schedule_java_codelysis_autoscaling}"),
               new MyJob('Scheduled-Coding-Simulator-Upscaling','coding-simulator','0 8 * * *',2,"${schedule_coding_simulator_autoscaling}"),
               new MyJob('Scheduled-Coding-Simulator-Downscaling','coding-simulator','0 22 * * *',1,"${schedule_coding_simulator_autoscaling}"),
               new MyJob('Scheduled-yolo-Upscaling','yolo','0 8 * * *',1,"${schedule_yolo_autoscaling}"),
               new MyJob('Scheduled-yolo-Downscaling','yolo','0 22 * * *',0,"${schedule_yolo_autoscaling}")



]
jobList.each{ k ->
    as_grp_name="${k.as_name}-as.${InternalDomain}"
    min_size="${k.autoscalingMinSize}"
    awsRegion="${awsRegion}"
    if("${k.schdeuleAutoscaling}" == "true"){
        job("${k.jobName}") {
            description("This job will scale mip ")
            triggers {
                cron("${k.triggerTime}")
            }
            steps {
                shell('#!/bin/bash\n' +
                        "new_minimum=\"${min_size}\"\n" +
                        "asg_name=\"${as_grp_name}\"\n" +
                        "region=\"${awsRegion}\"\n" +

                        'desired_capacity=`aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name my-auto-scaling-group  $asg_name --region $region | grep Desired | awk -F \": \" \'{print \$2}\' | sed  s#,##g`\n' +
                        'if [ $desired_capacity -ge $new_minimum ];\n' +
                        'then\n'+
                        'echo "setting min to "$new_minimum\n'+
                        'aws  autoscaling update-auto-scaling-group --auto-scaling-group-name $asg_name --min-size $new_minimum --region $region\n'+
                        'else\n'+
                        'echo "setting min and desired to "$new_minimum\n'+
                        'aws  autoscaling update-auto-scaling-group --auto-scaling-group-name $asg_name --min-size $new_minimum --desired-capacity $new_minimum --region $region\n' +
                        'fi'



                )
            }
        }}
}