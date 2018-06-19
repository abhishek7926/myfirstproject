#!/bin/bash

SERVER_NAME=$1

PID=`ps -ef | grep java | grep "${SERVER_NAME}/current-installation" | awk '{print $2}'`
kill $PID
died=false
while [ "$died" != "true" ]
do
   PID=`ps -ef | grep java | grep "${SERVER_NAME}/current-installation" | awk '{print $2}'`
   if [[ -z $PID ]]; then
                echo "Service stopped for server $SERVER_NAME"
                died=true
   else
                echo "waiting for 10 another seconds"
                sleep 10
   fi
done
