#!/bin/bash

SERVER_NAME=$1
/home/mettl/release/tomcat/stopServer.sh $SERVER_NAME
/home/mettl/release/tomcat/startServer.sh $SERVER_NAME

