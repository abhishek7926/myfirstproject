#!/bin/bash

# Check if Release # is specified
if [ $# -eq 0 ]
  then
    echo "Version Number to Deploy is not supplied"
    exit 0;
fi

component=$2
release_num=$1
base_nexus_url=$3
pre_argument=$4
service_type=$5

/home/mettl/release/java-services/stopSpringbootService.sh $component
/home/mettl/release/java-services/deployProctoringServiceWithCustomBaseNexusUrl.sh ${release_num} ${component} ${base_nexus_url}
/home/mettl/release/java-services/startRSimulatorsServices.sh ${component} "${pre_argument}" ${service_type}

