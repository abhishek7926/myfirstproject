#!/bin/bash

CURRENT_TIME=`date +%Y/%m/%d`
LOCAL_DIRECTORY=$1
LOG_FILE_EXTENSION=$2
BUCKET_NAME=$3
S3_DIRECTORY=$4
AWS_REGION=$5
BACKUP_LOG_DIR=s3://${BUCKET_NAME}/${S3_DIRECTORY}/${CURRENT_TIME}
echo "Moving ${LOG_FILE_INITIALS} logs to ${S3_DIRECTORY}"
for LOG_FILE in $(find ${LOCAL_DIRECTORY} -type f -name "$LOG_FILE_EXTENSION" )
do
	a=`echo $LOG_FILE | awk -F "/" '{print $NF}'`
        FILE_MODIFIED_TIME=`stat -c %y $LOG_FILE | sed 's/ /_/g'`
	echo "copy $LOG_FILE to ${BACKUP_LOG_DIR}/$a.${FILE_MODIFIED_TIME}"  
        aws s3 mv $LOG_FILE ${BACKUP_LOG_DIR}/`ec2metadata --instance-id`/$a.${FILE_MODIFIED_TIME} --region $AWS_REGION
done

