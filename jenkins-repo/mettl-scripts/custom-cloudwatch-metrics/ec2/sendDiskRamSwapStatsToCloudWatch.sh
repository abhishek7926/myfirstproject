##!/bin/bash
#echo StartTime:`date`
#autoscaling=$1
#if [ "$autoscaling" == "true" ] ;then
#aggregate="--auto-scaling=only"
#else
#aggregate=""
#fi
#/opt/custom-cloudwatch-metrics/aws-scripts-mon/mon-put-instance-data.pl --mem-util  --swap-util $aggregate
#echo EndTime:`date`
