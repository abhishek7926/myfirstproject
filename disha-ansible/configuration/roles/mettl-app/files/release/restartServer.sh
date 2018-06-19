#!/bin/bash

SERVER_NAME=$1
/home/mettl/release/stopServer.sh $SERVER_NAME
/home/mettl/release/startServer.sh $SERVER_NAME

