#!/bin/bash

# Check if gedit is running
if pgrep "mip_consumer" > /dev/null
then
    echo "Running"
else
    echo "Service Stopped" >> /home/mettl/mettl_logs/machine_check.log
    echo `date` >> /home/mettl/mettl_logs/machine_check.log
    echo "Starting Service again" >>  /home/mettl/mettl_logs/machine_check.log
    cd /home/mettl/cpp_mip/
    bin/mip_consumer &
   echo "Service started" >> /home/mettl/mettl_logs/machine_check.log
fi

