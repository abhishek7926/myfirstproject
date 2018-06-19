#!/bin/bash

# Check if Release # is specified
if [ $# -eq 0 ]
  then
    echo "Version Number to Deploy is not supplied"
    exit 0;
fi

version_num=$1
component=$2
echo $version_num > /tmp/docker_version
docker login --username=mettldocker --password=vallah@mettl@97
docker pull mettldocker/$component:$version_num
docker logout