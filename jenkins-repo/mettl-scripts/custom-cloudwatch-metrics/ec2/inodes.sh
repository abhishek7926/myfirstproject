#! /bin/bash
namespace=$1
REGION=$2
autoscaling=$3

python /opt/mettl-scripts/custom-cloudwatch-metrics/ec2/custom_metrics.py $namespace $REGION $autoscaling >> /var/log/custom-metric.log  2>&1

