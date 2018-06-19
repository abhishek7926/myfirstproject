#!/bin/bash

component=$1
SCRIPT_NAME=$2

cd /home/mettl/volume1/serviceAssesmblies/${component}/current-installation/${component}/

npm install
mkdir -p /home/mettl/mettl_logs/${component}
forever start -a -l /home/mettl/mettl_logs/${component}/${component}.log $SCRIPT_NAME
