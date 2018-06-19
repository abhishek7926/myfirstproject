#!/bin/bash

MONGO_INSTANCE_NAME=$1

PID=`ps -ef | grep mongo | grep $MONGO_INSTANCE_NAME | awk '{print $2}'`

if [[ -z $PID ]]; then
  echo "Mongo instance already stopped $MONGO_INSTANCE_NAME no need to forcefull shutdown"
else
  echo "Killing the mongo instance  with process id $PID"
  kill -9 $PID
fi

