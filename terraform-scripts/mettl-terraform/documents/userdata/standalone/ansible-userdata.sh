#!/bin/bash
apt-get install unzip
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
aws s3 cp s3://mettl-devops/generic-data-for-ansible-and-jenkins/ansible-userdata.sh ansible-userdata.sh --region ap-south-1
bash ansible-userdata.sh ${deployement_env} > /var/log/ansible-setup.log 2>&1
