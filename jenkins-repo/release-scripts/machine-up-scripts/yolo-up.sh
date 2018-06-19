#!/bin/bash

#/bin/su - mettl /home/mettl/release/misc/genericMachineUp.sh ${deployement_env} mettlspi web > /home/mettl/mettl_logs/machineup.log
deployement_env=$1
#private_ip = curl http://169.254.169.254/latest/meta-data/local-ipv4
#post_arg = "-cluster -cluster-host ${private_ip} -cluster-port 15701 -Dvertx.hazelcast.config=/home/mettl/mettlconfig/coding-simulators/simulators_cluster.xml -Dhazelcast.logging.type=slf4j"

/home/mettl/release/misc/genericFatJarUp.sh ${deployement_env} mettlImageProcessing "releases/com/mettl/" "java -Djava.library.path=/home/mettl/darknet -XX:+HeapDumpOnOutOfMemoryError -jar mettlImageProcessing.jar"
/home/mettl/release/misc/genericFatJarUp.sh ${deployement_env} mettlImageProcessing "releases/com/mettl/" "java -Djava.library.path=/home/mettl/darknet -XX:+HeapDumpOnOutOfMemoryError -jar mettlImageProcessing.jar"