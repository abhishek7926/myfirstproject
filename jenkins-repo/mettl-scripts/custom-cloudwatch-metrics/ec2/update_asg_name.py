from ec2_utils import EC2Utils
import sys
from random import randint
from time import sleep

sleep(randint(0,100))

region=sys.argv[1]
EC2Utils.update_and_get_autoscaling_name(region)
