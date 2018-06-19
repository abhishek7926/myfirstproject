#!/usr/bin/python

import sys
import pymssql
import ConfigParser

config = ConfigParser.RawConfigParser()

print sys.argv[1]
selectQuery=sys.argv[1]

config.read('/home/mettl/mettlconfig/connection.properties')
conn = pymssql.connect(host=config.get('db', 'host'), user=config.get('db', 'user'), password=config.get('db', 'password'), database=config.get('db', 'database'))

cur = conn.cursor()
#cur.execute('select * from statuses')
cur.execute(selectQuery)
row = cur.fetchone()
while row:
    print row
    row = cur.fetchone()

conn.close()

