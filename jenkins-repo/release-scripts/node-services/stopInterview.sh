#!/bin/bash

PID=$(ps -ef | grep -i "angular" |grep -v grep| awk '{print $2}')

if [ -z $PID ]
then
        echo "Service already stopped for server, no need to check further"
else
        echo "Killing the service with process id $PID"
        kill $PID

        while [[ ! -z $PID ]]; do
          sleep 10
          PID=$(ps -ef | grep -i "ng serve" |grep -v grep| awk '{print $2}')
        done
fi
