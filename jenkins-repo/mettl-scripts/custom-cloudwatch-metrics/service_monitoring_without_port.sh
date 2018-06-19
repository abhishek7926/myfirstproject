#! /bin/bash
set -x
namespace=$1
service_name=$2
autoscaling=$3
region=$4
date=`date`
EC2_INSTANCE_ID=$(ec2metadata --instance-id)
service_status=`ps -ef | grep $service_name | grep java`
if [ -z "$service_status" ]; then
service_value=0
else
service_value=1
fi
if [ "$autoscaling" == "true" ]
then
echo "publishing autoscaling metrics"
autoscaling_group_name=$(/usr/local/bin/aws ec2 describe-instances --instance-id $EC2_INSTANCE_ID --query 'Reservations[*].Instances[*].[Tags[?Key==`aws:autoscaling:groupName`]]' --region $region | grep Value | awk -F ": " '{print $2}' | awk -F '"' '{print $2}')
/usr/local/bin/aws cloudwatch put-metric-data --metric-name ServiceProcess --namespace $namespace --dimensions "AutoScalingGroupName=$autoscaling_group_name,ServiceProcess=metric" --value $service_value --timestamp "$date" --region $region
else
echo "not publishing autoscaling"
fi

/usr/local/bin/aws cloudwatch put-metric-data --metric-name ServiceProcess --namespace $namespace --dimensions InstanceId=$EC2_INSTANCE_ID,ServiceProcess=metric --value $service_value --timestamp "$date" --region $region

