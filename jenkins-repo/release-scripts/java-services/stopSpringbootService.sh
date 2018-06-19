#!/bin/bash

SERVER_NAME=$1

for i in {1..10}; do
        PID=`ps -ef | grep java | grep -w "${SERVER_NAME}".jar | awk '{print $2}'`

        if [[ -z $PID ]]; then
                echo "Service already stopped for server $SERVER_NAME no need to check further"
                exit 0
        else
                echo "Gracefully Killing the service with process id $PID"
                kill $PID
                sleep 10
        fi
done

PID=`ps -ef | grep java | grep "${SERVER_NAME}" | awk '{print $2}'`

if [[ -z $PID ]]; then
        echo "Service already stopped for server $SERVER_NAME no need to check further"
else
        echo "Forcefully Killing the service with process id $PID"
        kill -9 $PID
        sleep 10
fi

