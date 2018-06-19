#!/bin/bash
component="htmlToPdfService"
cd /home/mettl/volume1/serviceAssesmblies/${component}/current-installation/${component}/src

forever start -o  /home/mettl/mettl_logs/${component}_console.log -minUptime=100 serverRunner.js 8030 /home/mettl/mettl_logs/tempPdfs/
