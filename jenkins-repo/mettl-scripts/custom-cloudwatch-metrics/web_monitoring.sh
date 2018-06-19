#!/bin/bash
set -x
url=$1
response_check=$2
namespace=$3
region=$4
response=$( wget  --delete-after --server-response -q $url 2>&1 | awk 'NR==1{print $2}' )
if [ "$response_check" == "$response" ]; then
	response_output=1
else
	touch /var/log/web_monitoring_failed.log
	echo `date` >> /var/log/web_monitoring_failed.log
	echo "$url" >> /var/log/web_monitoring_failed.log
	echo "$response" >> /var/log/web_monitoring_failed.log
	response_output=0
fi
/usr/local/bin/aws cloudwatch put-metric-data --metric-name Website_Response_check --namespace $namespace --value $response_output --dimensions Web_monitoring=metric,Url=$url,Desired_response_code=$response_check --region $region
