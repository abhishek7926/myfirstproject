
#!/bin/bash

function moveGenericLogsToS3fromFolder() {
       CURRENT_TIME=`date --date yesterday +%F`
#       CURRENT_TIME=`date +%Y/11/27`
instance_id=`ec2metadata --instance-id`
        LOCAL_DIRECTORY=$1
        S3_DIRECTORY=$2
        LOG_FILE_INITIALS=$3
        BACKUP_LOG_DIR=s3://mettl/logs/${S3_DIRECTORY}/${CURRENT_TIME}/${instance_id}

        echo "Moving ${LOG_FILE_INITIALS} logs to ${S3_DIRECTORY}"

        for LOG_FILE in $(find ${LOCAL_DIRECTORY}/${LOG_FILE_INITIALS}.* -type f)
        do
                echo $LOG_FILE
                FILE_MODIFIED_TIME=`stat -c %y $LOG_FILE | sed 's/ /_/g'`
                echo "Copying file to S3 with name ${LOG_FILE_INITIALS}.${FILE_MODIFIED_TIME}"
                aws s3 mv $LOG_FILE ${BACKUP_LOG_DIR}/${LOG_FILE_INITIALS}.${FILE_MODIFIED_TIME}
        done
#       find /home/mettl/mettl_logs/${COMPONENT}-mettl.log.* -type f -exec aws s3 mv '{}' ${BACKUP_LOG_DIR} \;
}

function moveKurentoLogsToS3fromFolder() {

CURRENT_TIME=`date --date yesterday +%F`
LOCAL_DIRECTORY=$1
S3_DIRECTORY=$2
instance_id=`ec2metadata --instance-id`
BACKUP_LOG_DIR=s3://mettl/logs/${S3_DIRECTORY}/${CURRENT_TIME}/${instance_id}
echo "Moving ${LOG_FILE_INITIALS} logs to ${S3_DIRECTORY}"
for LOG_FILE in $(find ${LOCAL_DIRECTORY}/*.log -type f)
do
                name="media$(echo $LOG_FILE | awk '{split($0,b,"media"); print b[3]}')"
                echo $LOG_FILE

                FILE_MODIFIED_TIME=`stat -c %y $LOG_FILE | sed 's/ /_/g'`
                echo "Copying file to S3 with name ${LOG_FILE}.${FILE_MODIFIED_TIME}"
                aws s3 mv /home/mettl/mettl_logs/kurento-media-server/logs/$name ${BACKUP_LOG_DIR}/$name.${FILE_MODIFIED_TIME}
#                break
done




}
