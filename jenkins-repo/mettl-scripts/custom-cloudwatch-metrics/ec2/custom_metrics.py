__author__ = 'shanky'

import subprocess
import boto3
from decimal import Decimal
import sys
from datetime import datetime
import os
from ec2_utils import EC2Utils
from cloudwatch_utils import CloudWatchUtils
import commands
from memory_utils import MemoryUtils

def get_memory_metric_data(metric_name, metric_value):
    memory_usage_dimensions=[ec2_dimension]
    memory_usage_metric_data = CloudWatchUtils.get_metric_Data(metric_name,memory_usage_dimensions,metric_value,"Percent")
    return memory_usage_metric_data

startTime = datetime.now()
print startTime, "starting publishing custom metrics"

memory_utils_obj =  MemoryUtils()
namespace=sys.argv[1]
region=sys.argv[2]
is_autoscaling_str=sys.argv[3]
is_autoscaling = True if is_autoscaling_str.lower()=="true" else False

client = boto3.client('cloudwatch', region_name=region)

instance_id = EC2Utils().get_ec2_instance_id()
if is_autoscaling:
    asg_name = EC2Utils().get_autoscaling_name(region)
    if asg_name == "not-in-autoscaling":
        ec2_dimension = CloudWatchUtils.get_dimension("InstanceId",instance_id)
    else:
        ec2_dimension = CloudWatchUtils.get_dimension("AutoScalingGroupName",asg_name)
else:
    ec2_dimension = CloudWatchUtils.get_dimension("InstanceId",instance_id)

metric_data_list=[]
metric_command_list=[("InodeUsage","-hi"), ("DiskUsage","-h")]
for metric_command in metric_command_list:
    metric_name=metric_command[0]
    command_parameter = metric_command[1]

    filesystem_command_output = subprocess.check_output(['df', command_parameter])

    filesystem_list = filesystem_command_output.splitlines()
    for line in filesystem_list:
        split_list = line.split()
        file_system=split_list[0]
        mounted_on = split_list[5]
        use_percent_str = split_list[4]
        if "/dev"  in file_system:
            dimensions=[CloudWatchUtils.get_dimension(metric_name,"metric")
                ,ec2_dimension
                ,CloudWatchUtils.get_dimension("Device",file_system)
                ,CloudWatchUtils.get_dimension("MountPath",mounted_on)]
            use_percent = Decimal(use_percent_str.replace("%",''))
            metric_data=CloudWatchUtils.get_metric_Data(metric_name,dimensions, use_percent,"Percent")
            metric_data_list.append(metric_data)


load_avg_metric_name = "LoadAverage"
load_command = 'cat /proc/loadavg | awk \'{print $1}\''
(exit_code, load_command_output) = commands.getstatusoutput(load_command)
load_command_output = float(load_command_output)
load_avg_dimensions=[CloudWatchUtils.get_dimension(load_avg_metric_name,"metric")
    ,ec2_dimension]
load_avg_metric_data = CloudWatchUtils.get_metric_Data_without_unit(load_avg_metric_name,load_avg_dimensions, load_command_output)
metric_data_list.append(load_avg_metric_data)

metric_data_list.append(get_memory_metric_data("MemoryUtilization",memory_utils_obj.get_memory_usage_percentage()))
metric_data_list.append(get_memory_metric_data("SwapUtilization",memory_utils_obj.get_swap_percentage()))


instance_id_call_response = client.put_metric_data(
    Namespace=namespace,
    MetricData=metric_data_list
)
print "time taken", datetime.now() - startTime

