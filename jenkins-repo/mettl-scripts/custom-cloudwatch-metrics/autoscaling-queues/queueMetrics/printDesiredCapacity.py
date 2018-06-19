import sys
import boto3
autoscaling_group_name=sys.argv[1]
region=sys.argv[2]
# Let's use Amazon S3
client= boto3.client('autoscaling', region_name=region)
group_details = client.describe_auto_scaling_groups(
    AutoScalingGroupNames=[
        autoscaling_group_name
    ]
)
desired_capacity=group_details['AutoScalingGroups'][0]['DesiredCapacity']
print desired_capacity

