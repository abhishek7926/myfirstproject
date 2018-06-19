#!/bin/bash

PYTHON_SERVICE=$1

for i in {1..10}; do
	PID=`ps -ef | grep python | grep $PYTHON_SERVICE | awk '{print $2}'`

	if [[ -z $PID ]]; then
		echo "Python Service already stopped $PYTHON_SERVICE no need to forcefull shutdown"
		exit 0
	else
		echo "Killing the service with process id $PID"
		kill $PID
		sleep 10
	fi
done

PID=`ps -ef | grep python | grep $PYTHON_SERVICE | awk '{print $2}'`

if [[ -z $PID ]]; then
	echo "Python Service already stopped $PYTHON_SERVICE no need to forcefull shutdown"
else
	echo "Forcefully killing the service with process id $PID"
	kill -9 $PID
fi

