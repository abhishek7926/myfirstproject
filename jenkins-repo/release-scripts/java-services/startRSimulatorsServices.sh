#!/bin/bash
component=$1
pre_argument=$2
service_type=$3

private_ip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
post_arg="-cluster -cluster-host ${private_ip} -cluster-port 15701 -Dvertx.hazelcast.config=/home/mettl/mettlconfig/coding-simulators/simulators_cluster.xml -Dhazelcast.logging.type=slf4j -Denvironment=${service_type}"

/home/mettl/release/java-services/startSpringbootServiceWithArguments.sh $component "$pre_argument" "$post_arg"