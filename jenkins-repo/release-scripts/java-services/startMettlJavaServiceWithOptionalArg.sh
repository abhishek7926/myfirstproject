#!/bin/bash
component=$1
optionalArgument=$2
if [ "$component" = "grader" ]; then
consumers=$3
fi
cd /home/mettl/volume1/serviceAssesmblies/${component}/current-installation
#This is a temporary hack should be removed
chmod +x  bin/${component}

if [ $component == "grader" ]; then
bin/${component}  ${optionalArgument} ${consumers} >> /home/mettl/mettl_logs/${component}_console.log 2>&1 &
echo $! >> /home/mettl/${component}_${optionalArgument}.pid
else
bin/${component}  ${optionalArgument} >> /home/mettl/mettl_logs/${component}_console.log 2>&1 &
echo $! >> /home/mettl/${component}_${optionalArgument}.pid

fi
