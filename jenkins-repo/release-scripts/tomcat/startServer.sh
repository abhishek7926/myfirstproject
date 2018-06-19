#!/bin/bash

SERVER_NAME=$1
TOMCAT_DIR=/home/mettl/volume1/${SERVER_NAME}

echo "Starting mettl server"
$TOMCAT_DIR/bin/startup.sh

