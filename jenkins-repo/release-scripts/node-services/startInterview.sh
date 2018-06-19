#!/bin/bash

component=$1
env=$2

cd /home/mettl/volume1/serviceAssesmblies/${component}/current-installation/${component}/

npm install
ng build --env=$env