#!/bin/bash
set -x
REMOTEHOST=$1
REMOTEPORT=$2
NAMESPACE=$3
TIMEOUT=1
REGION=$4

if nc -w $TIMEOUT -z $REMOTEHOST $REMOTEPORT; then
    response=1
else
    response=0
fi

/usr/local/bin/aws cloudwatch put-metric-data --metric-name Port_Response_check --namespace $NAMESPACE --value $response --dimensions Tcp_monitoring=metric,Url=$REMOTEHOST,Port=$REMOTEPORT --region $REGION
