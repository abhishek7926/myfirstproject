#!/bin/bash
RELEASE_ARCHIVE=$1
SERVER_NAME=$2
TOMCAT_DIR=/usr/local/$2

/home/mettl/release/stopServer.sh $SERVER_NAME

echo "Clearing ROOT directory"
rm -rf $TOMCAT_DIR/webapps/ROOT/*;

echo "Placing the new content in web server"
unzip $RELEASE_ARCHIVE -d $TOMCAT_DIR/webapps/ROOT/;

/home/mettl/release/startServer.sh $SERVER_NAME

