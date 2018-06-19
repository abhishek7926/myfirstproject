#!/bin/bash

# Check if Release # is specified
if [ $# -eq 0 ]
  then
    echo "Version Number to Deploy is not supplied"
    exit 0;
fi

component=$2
release_num=$1

source /home/mettl/release/${component}.properties
/home/mettl/release/stopJavaService.sh $component

/home/mettl/release/deployMettlJavaService.sh ${release_num} ${component}
source /home/mettl/release/${component}.properties
/home/mettl/release/startJavaService.sh ${component}
