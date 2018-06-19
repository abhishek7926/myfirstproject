import calendar
import sys
import time
import os
from xml.dom.minidom import parse,parseString
import requests

"""
set the mode for level of detail/format to be printed
FULL - QUEUE_NAME consumers:value1  queuesize:value2    enqcount:value3    deqcount:value4
INFO - QUEUE_NAME consumers:value1  queuesize:value2
CSV  - QUEUE_NAME,value1,value2,value3,value4
"""
mode="FULL"


if len(sys.argv) == 4:
  base_name=os.path.basename(__file__)
  print """
Usage: ./%s <activemq_host_ip> <port> <username> <password>
Example: ./%s 192.168.0.1
""" % (base_name, base_name)
  sys.exit(0)
else:
  host_ip=sys.argv[1]
  port=sys.argv[2] 
  username=sys.argv[3]
  password=sys.argv[4]
  
url='http://'+host_ip+':'+port+'/admin/xml/queues.jsp'
print "URL:" , url

xmldata=requests.get(url, auth=(username, password)).content
f = open("/home/mettl/data.xml", "w")
f.write( str(xmldata)  )      # str() converts to string
f.close()

#print xmldata
try:
  dom=parse("/home/mettl/data.xml")
#print dom
except:
  print "Error connecting to activemq, stopping."
  sys.exit(2)
for node in dom.getElementsByTagName('queue'):
  con_count= int(node.childNodes[1].getAttribute('consumerCount'))
  enq_count= int(node.childNodes[1].getAttribute('enqueueCount'))
  deq_count= int(node.childNodes[1].getAttribute('dequeueCount'))
  queue_size= int(node.childNodes[1].getAttribute('size'))
  queue_name= str(node.getAttribute('name'))
  if mode=="FULL":
    print "%-30s    consumers:%-7d    queuesize:%-7d    enqcount:%-7d    deqcount:%-7d" % (queue_name,con_count,queue_size,enq_count,deq_count)
  elif mode=="CSV":
    print queue_name,con_count,queue_size,enq_count,deq_count
  else:
    print "%-30s    consumers:%-7d    queuesize:%-7d" % (queue_name,con_count,queue_size)

