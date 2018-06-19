#!/bin/bash

SERVICE_NAME=$1
OptionalArgument=$2
file="/home/mettl/${SERVICE_NAME}_${OptionalArgument}.pid"
if [ -f "$file" ]
then
pids=`cat $file`
arr=$(echo $pids | tr "," "\n")
for x in $arr
do
        for i in {1..10}; do
                PID=`ps -ef | grep java | grep "${SERVICE_NAME}/current-installation" | grep $x | awk '{print $2}'`

                if [[ -z $PID ]]; then
                        echo "process id $x dead."
                        break
                else
                        echo "Gracefully Killing the service with process id $PID"
                        kill $PID
                        sleep 10
                fi
        done


        PID=`ps -ef | grep java | grep "${SERVICE_NAME}/current-installation" | grep $x | awk '{print $2}'`

        if [[ ! -z $PID ]]; then
                echo "Forcefully Killing the service with process id $PID"
                kill -9 $PID
                sleep 10
        fi
done
rm -rf $file
fi
