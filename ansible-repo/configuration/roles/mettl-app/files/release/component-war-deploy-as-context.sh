#!/bin/bash
RELEASE_ARCHIVE=$1
SERVER_NAME=$2
TOMCAT_DIR=/usr/local/$2

/home/mettl/release/stopServer.sh $SERVER_NAME

echo "Clearing context directory"
rm -rvf $TOMCAT_DIR/webapps/${RELEASE_ARCHIVE}*;

echo "Placing the new content in web server"
cp -v /home/mettl/${RELEASE_ARCHIVE}.war  $TOMCAT_DIR/webapps/;

/home/mettl/release/startServer.sh $SERVER_NAME
