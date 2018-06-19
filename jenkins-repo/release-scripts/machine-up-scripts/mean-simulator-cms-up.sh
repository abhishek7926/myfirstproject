#!/bin/bash

ENV=$1
base_nexus_url="releases/com/mettl/simulators/"
COMPONENT="container_server_manager"
service_type="MEAN"
pre_argument=""
NODE_COMPONENT="meanserver-node-client"
node_script="app.js"


aws s3 cp s3://deployement-versions/$ENV/$service_type/index.html . --region ap-south-1
VERSION=`cat index.html`
echo "Version found is $VERSION"

echo "${COMPONENT} service is  installing with version ${VERSION}"

private_ip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
post_arg="-cluster -cluster-host ${private_ip} -cluster-port 15701 -Dvertx.hazelcast.config=/home/mettl/mettlconfig/coding-simulators/simulators_cluster.xml -Dhazelcast.logging.type=slf4j -Denvironment=${service_type}"


/home/mettl/release/java-services/deployProctoringServiceWithCustomBaseNexusUrl.sh ${VERSION} ${COMPONENT} ${base_nexus_url}
/home/mettl/release/java-services/startSpringbootServiceWithArguments.sh $COMPONENT "$pre_argument" "$post_arg"

echo "${NODE_COMPONENT} service is  installing with version ${VERSION}"

/home/mettl/release/misc/deployMettlZipComponentWithCustumBaseNexsusUrl.sh $VERSION $NODE_COMPONENT ${base_nexus_url}
/home/mettl/release/node-services/startRServerNodeClient.sh $NODE_COMPONENT $node_script