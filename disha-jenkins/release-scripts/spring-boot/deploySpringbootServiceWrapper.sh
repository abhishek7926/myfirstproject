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

/home/mettl/release/spring-boot/stopSpringbootService.sh $component
/home/mettl/release/spring-boot/deploySpringbootService.sh ${release_num} ${component}
/home/mettl/release/spring-boot/startspringbootservice.sh ${component} ${optional_argument}
