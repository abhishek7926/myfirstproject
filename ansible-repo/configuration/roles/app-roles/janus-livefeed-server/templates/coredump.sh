#!/bin/bash

# Get parameters passed from the kernel
EXE=`echo $1 | sed -e "s,!,/,g"`
check_if_janus=`echo ${EXE} | awk -F "/" '{print $NF}'`
TSTAMP=$8
echo $check_if_janus > /tmp/pr
if [ $check_if_janus == "janus" ]; then
# Read core file from stdin
COREFILE=/home/mettl/janus_core_${TSTAMP}
cat > ${COREFILE}
/opt/mettl-scripts/log-backup/move-logs.sh /home/mettl/ janus_core_*  {{ logs_bucket }} {{ hostname }}/core-dump {{ aws_region }} >> /home/mettl/mettl_logs/coredumpbackup.log 2>&1
else
/usr/share/apport/apport $2 $3 $4 $5
fi