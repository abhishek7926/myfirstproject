#!/bin/bash

component=$1
SCRIPT_NAME=$2

cd /home/mettl/volume1/serviceAssesmblies/${component}/current-installation/${component}/

npm install
gulp scripts
forever start dist/$SCRIPT_NAME
