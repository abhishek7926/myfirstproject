#!/bin/bash
component=$1
python_parameter=$2
cd /home/mettl/volume1/serviceAssesmblies/${component}/current-installation/${component}

eval "python ${python_parameter}" >> /home/mettl/mettl_logs/${component}_console.log 2>&1 "&"
