#!/bin/bash
component=$1
pre_argument=$2
post_argument=$3

cd /home/mettl/volume1/serviceAssesmblies/${component}/current-installation
#This is a temporary hack should be removed

#chmod +x  bin/${component}
#eval bin/${component} ${optionalArgument}  >> /home/mettl/mettl_logs/${component}_console.log 2>&1 "&"
eval java -jar $pre_argument ${component}.jar $post_argument >> /home/mettl/mettl_logs/${component}_console.log 2>&1 "&"

