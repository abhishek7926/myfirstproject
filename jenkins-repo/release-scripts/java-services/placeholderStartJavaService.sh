#!/bin/bash
component=$1
startCommand=$2
cd /home/mettl/volume1/serviceAssesmblies/${component}/current-installation
#This is a temporary hack should be removed

#chmod +x  bin/${component}
#eval bin/${component} ${optionalArgument}  >> /home/mettl/mettl_logs/${component}_console.log 2>&1 "&"
eval $startCommand >> /home/mettl/mettl_logs/${component}_console.log 2>&1 "&"

