#!/usr/bin/env python

import telnetlib
import boto
import math
from boto.ec2.autoscale import AutoScaleConnection


#HOST = '192.168.2.49'
HOST = 'chat.mettl.com'
PORT = 1986

#Capacity of a MIP instance to handle clients
#Currently we are using Micro Instance, it's capacity is 20
mipInstanceClientCapacity = 50

tn = telnetlib.Telnet(HOST, PORT)
tn.write('dump' + "\n")
dumpResult = tn.read_until('Connection closed by foreign host')
print ('Output of Dump command: ' + dumpResult)
start = dumpResult.index('Total Active User IDs : ') + 24
end = dumpResult.index(' ', start + 1)

activeClients = dumpResult[ start : end ]
print ('Active clients in system are: ' + activeClients)

desiredMipInstances = int(math.ceil((int(activeClients)  )/ mipInstanceClientCapacity) + 1)
print('Desired MIP instances are: ' + str(desiredMipInstances))


conn = boto.ec2.autoscale.connect_to_region('ap-southeast-1')
scalingGroupName='Production MIP AutoScaleGroup'
scalingGroup=conn.get_all_groups(names=[scalingGroupName])[0]
#desiredMipInstances=2
print('Desired MIP instances are: ' + str(desiredMipInstances))
scalingGroup.set_capacity(desiredMipInstances)
