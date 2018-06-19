#!/bin/bash

REGION=$1
autoscaling=$2
instance_id=`ec2metadata --instance-id`
if [ "$autoscaling" == "true" ]
    then
        cd /opt/mettl-scripts/custom-cloudwatch-metrics/ec2
        python update_asg_name.py  $REGION
fi
