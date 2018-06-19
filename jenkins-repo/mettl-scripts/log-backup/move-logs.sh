#!/bin/bash

SHELL=/bin/bash
PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

CURRENT_TIME=`date +%Y/%m/%d`
LOCAL_DIRECTORY=$1
LOG_FILE_EXTENSION=$2
BUCKET_NAME=$3
S3_DIRECTORY=$4
AWS_REGION=$5

BACKUP_LOG_DIR=s3://${BUCKET_NAME}/${S3_DIRECTORY}/${CURRENT_TIME}

echo "Moving mettl_logs to s3 at location-  ${BUCKET_NAME}/${S3_DIRECTORY}"

for LOG_FILE in $(find $LOCAL_DIRECTORY -type f -name "$LOG_FILE_EXTENSION")
do
        echo $LOG_FILE
        p=`echo $LOG_FILE | sed -e "s#^$LOCAL_DIRECTORY/##g"`
        FILE_MODIFIED_TIME=`stat -c %y $LOG_FILE | sed 's/ /_/g'`
        echo "Copying file to S3 with name ${p}.${FILE_MODIFIED_TIME}"
        aws s3 mv $LOG_FILE ${BACKUP_LOG_DIR}/`ec2metadata --instance-id`/$p.${FILE_MODIFIED_TIME} --region ${AWS_REGION}
done
