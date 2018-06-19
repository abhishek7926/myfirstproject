#!/bin/bash
component="englishSimulator"
cd /home/mettl/volume1/serviceAssesmblies/${component}/current-installation/grader

eval "python src/service/Web.py" >> /home/mettl/mettl_logs/EWService_console.log 2>&1 "&"
