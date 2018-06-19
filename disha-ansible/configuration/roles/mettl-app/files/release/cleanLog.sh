#!/bin/bash

function moveMettlLogsToS3() {
	CURRENT_TIME=`date +%Y/%m/%d`
	COMPONENT=$1
        BACKUP_LOG_DIR=s3://mettl/logs/${COMPONENT}/${CURRENT_TIME}

        echo "Moving ${COMPONENT} logs to ${BACKUP_LOG_DIR}"
	for LOG_FILE in $(find /home/mettl/mettl_logs/mettl.log.* -type f)
	do
		echo $LOG_FILE
		FILE_MODIFIED_TIME=`stat -c %y $LOG_FILE | sed 's/ /_/g'`
		echo "Copying file to S3 with name mettl.log.${FILE_MODIFIED_TIME}"
		aws s3 mv $LOG_FILE ${BACKUP_LOG_DIR}/mettl.log.${FILE_MODIFIED_TIME}
	done

	echo "Finished moving files"
}

function moveLogsToS3() {
	CURRENT_TIME=`date +%Y/%m/%d`
	COMPONENT=$1
	BACKUP_LOG_DIR=s3://mettl/logs/${COMPONENT}/${CURRENT_TIME}

	echo "Moving ${COMPONENT} logs to ${BACKUP_LOG_DIR}"

	for LOG_FILE in $(find /home/mettl/mettl_logs/${COMPONENT}-mettl.log.* -type f)
        do
                echo $LOG_FILE
                FILE_MODIFIED_TIME=`stat -c %y $LOG_FILE | sed 's/ /_/g'`
                echo "Copying file to S3 with name mettl.log.${FILE_MODIFIED_TIME}"
                aws s3 mv $LOG_FILE ${BACKUP_LOG_DIR}/${COMPONENT}-mettl.log.${FILE_MODIFIED_TIME}
        done
#	find /home/mettl/mettl_logs/${COMPONENT}-mettl.log.* -type f -exec aws s3 mv '{}' ${BACKUP_LOG_DIR} \;
}
