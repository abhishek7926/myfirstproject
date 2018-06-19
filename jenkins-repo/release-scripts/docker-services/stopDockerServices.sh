#!/bin/bash

CID=`docker ps |grep -v CONTAINER |awk '{print $1}'`

if [ -z $CID ]
then
        echo "Service already stopped for server, no need to check further"
else
        echo "Killing the service with container id $CID"
        docker kill $CID

        while [[ ! -z $CID ]]; do
          sleep 10
          CID=`docker ps |grep -v CONTAINER |awk '{print $1}'`
        done
fi

