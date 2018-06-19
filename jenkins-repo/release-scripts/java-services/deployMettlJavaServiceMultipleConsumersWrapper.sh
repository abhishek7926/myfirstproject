#!/bin/bash

# Check if Release # is specified
if [ $# -eq 0 ]
  then
    echo "Version Number to Deploy is not supplied"
    exit 0;
fi

component=$2
release_num=$1
consumers=$3

/home/mettl/release/java-services/stopJavaService.sh $component

/home/mettl/release/java-services/deployMettlJavaService.sh ${release_num} ${component}
/home/mettl/release/java-services/startJavaServiceMultipleConsumers.sh ${component} ${consumers}



