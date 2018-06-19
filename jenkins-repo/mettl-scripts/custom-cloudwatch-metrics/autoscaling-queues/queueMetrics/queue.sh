#!/bin/bash
QUEUE_NAME=$1
IP=$2
PORT=$3
USER=$4
PWD=$5
AUTO_SCALING_GRP=$6
namespace=$7
region=$8
perl_script_location="/opt/mettl-scripts/custom-cloudwatch-metrics/autoscaling-queues/queueMetrics/getCountforQueue.pl"
pyhton_script_location="/opt/mettl-scripts/custom-cloudwatch-metrics/autoscaling-queues/queueMetrics/printDesiredCapacity.py"
#echo $AUTO_SCALING_GRP
event=`perl $perl_script_location $QUEUE_NAME $IP $PORT $USER $PWD`
#echo $event
current_desired_capacity=`python $pyhton_script_location "$AUTO_SCALING_GRP" "$region"`
echo "#########################################"
echo `date`
echo "current_desired_capacity "$current_desired_capacity
echo "event count $event"
pending_messages_per_machine=$((event/current_desired_capacity))
echo "Pending messages $pending_messages_per_machine"
/usr/local/bin/aws cloudwatch put-metric-data --metric-name "AveragePendingMessages" --namespace $namespace --value $pending_messages_per_machine --dimensions AveragePendingMessages=metric,QueueName=$QUEUE_NAME --region $region

