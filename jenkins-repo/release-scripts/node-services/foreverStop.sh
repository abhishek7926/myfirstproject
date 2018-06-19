#!/bin/bash

SCRIPT_NAME=$1


PID=`forever list | grep "${SCRIPT_NAME}" | awk '{print $7}'`

if [ -z $PID ]
then
        echo "Service already stopped for server $SCRIPT_NAME no need to check further"
else
        echo "Killing the service with process id $PID"
        forever stop $PID

        while [[ ! -z $PID ]]; do
          sleep 10
          PID=`forever list | grep "${SCRIPT_NAME}" | awk '{print $7}'`
        done
fi

