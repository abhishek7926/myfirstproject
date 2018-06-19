#!/bin/bash

component=$1
portString=$2
versionNum=`cat /tmp/docker_version`
echo "Searching imageid for version $versionNum"
ImageID=`docker images |grep $component |grep $versionNum | awk '{print $3}'`

echo "Starting Docker for Image ID $ImageID"
docker run -d -p $portString $ImageID
