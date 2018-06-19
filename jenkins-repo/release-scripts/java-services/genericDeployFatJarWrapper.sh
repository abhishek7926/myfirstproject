#!/bin/bash

# Check if Release # is specified
if [ $# -eq 0 ]
  then
    echo "Version Number to Deploy is not supplied"
    exit 0;
fi

release_num=$1
component=$2
base_nexus_url=$3
startCommand=$4

/home/mettl/release/java-services/stopSpringbootService.sh $component
/home/mettl/release/java-services/deployProctoringServiceWithCustomBaseNexusUrl.sh ${release_num} ${component} "${base_nexus_url}"
/home/mettl/release/java-services/placeholderStartJavaService.sh ${component} "${startCommand}"
