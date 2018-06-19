__author__ = 'shanky'

import boto3
import urllib2

class EC2Utils:
    @staticmethod
    def get_autoscaling_name(region):
        asg_name = None
        try:
            with open('/opt/asg_name', 'r') as f:
                asg_name = f.readline()
        except IOError:
            print('/opt/asg_name not found. Creating and updating asgname')
            asg_name = EC2Utils.update_and_get_autoscaling_name(region)

        if not asg_name:
            asg_name = EC2Utils.update_and_get_autoscaling_name(region)
        return asg_name

    @staticmethod
    def get_ec2_instance_id():
        instance_id_call_response = urllib2.urlopen("http://169.254.169.254/latest/meta-data/instance-id")
        instance_id = instance_id_call_response.read()
        return instance_id

    @staticmethod
    def update_and_get_autoscaling_name(region):
        instance_id = EC2Utils.get_ec2_instance_id()
        client = boto3.client('ec2',
                              region_name = region
                              )

        response = client.describe_instances(
            InstanceIds=[
                instance_id,
            ]
        )
        reservations = response['Reservations']
        instances = reservations[0]['Instances']
        concerned_instance = instances[0]
        instance_tags = concerned_instance['Tags']
        asg_name = None
        for tag in instance_tags:
            if tag['Key'] == 'aws:autoscaling:groupName':
                asg_name = tag['Value']
        if asg_name is None:
            asg_name = 'not-in-autoscaling'

        with open('/opt/asg_name', 'w') as f:
            f.write(asg_name)

        return asg_name


