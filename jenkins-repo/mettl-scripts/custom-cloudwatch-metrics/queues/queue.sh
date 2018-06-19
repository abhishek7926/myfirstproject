#!/bin/bash
QUEUE_NAME=$1
IP=$2
PORT=$3
USER=$4
PWD=$5
namespace=$6
region=$7
queue_file_location="/opt/$QUEUE_NAME.txt"
python_script_location="/opt/mettl-scripts/custom-cloudwatch-metrics/queues/active_mq_parser.py"
event=`python $python_script_location $IP $PORT $USER $PWD | grep -w $QUEUE_NAME | awk '{print $3}' | awk -F ":" '{print $2}'`
consumers=`python $python_script_location $IP $PORT $USER $PWD | grep -w $QUEUE_NAME | awk {'print $2'} | awk -F ":" {'print $2'}`
current_dequeue_count=`python $python_script_location $IP $PORT $USER $PWD |  grep -w $QUEUE_NAME | awk {'print $NF'} | awk -F ":" {'print $2'}`
if [ -s $queue_file_location ]; then
	echo "File is not empty and contains data"
	last_dequeue_count=`awk 'END{print}' $queue_file_location`
	diff=$(( current_dequeue_count-last_dequeue_count ))
	echo "diff,$diff"
	rate=$(( diff/20 ))
	echo "rate,$rate"
	/usr/local/bin/aws cloudwatch put-metric-data --metric-name "QueueSize" --namespace $namespace --value $event --dimensions QueueSize=metric,QueueName=$QUEUE_NAME --region $region
	/usr/local/bin/aws cloudwatch put-metric-data --metric-name "Consumers" --namespace $namespace --value $consumers --dimensions Consumers=metric,QueueName=$QUEUE_NAME --region $region
	/usr/local/bin/aws cloudwatch put-metric-data --metric-name "Consumption/Production rate" --namespace $namespace --value $rate --dimensions Consumption-Production-Rate=metric,QueueName=$QUEUE_NAME --region $region
	echo "####################################"
	echo -e "\nQueue Name:\t$1\n`date`\nQueue_Size:\t$event\nConsumers:\t$consumers\nConsumption/Production Rate:\t$rate\nCurrent Dequeue\t:$current_dequeue_count\nLast_Dequeue_size:\t$last_dequeue_count"
        echo $current_dequeue_count > $queue_file_location


else
	echo "File is either empty or does not exist"
    	echo $current_dequeue_count > $queue_file_location
fi


