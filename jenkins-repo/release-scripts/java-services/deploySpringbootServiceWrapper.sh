#!/bin/bash

# Check if Release # is specified
if [ $# -eq 0 ]
  then
    echo "Version Number to Deploy is not supplied"
    exit 0;
fi

component=$2
release_num=$1
optional_argument=$3

/home/mettl/release/java-services/stopSpringbootService.sh $component
/home/mettl/release/java-services/deployProctoringService.sh ${release_num} ${component}
/home/mettl/release/java-services/startSpringbootService.sh ${component} ${optional_argument}

