#!/usr/bin/env python

import pexpect
import time
import re
import random

# Tree of belief decisions to write into meta agent
choose_belief_1 = ["leg1","leg2","leg3","leg4"] #For a-c
choose_belief_2 = ["","bored"]
choose_belief_3 = ["m000l1","m001l1","m010l1","m011l1","m100l1","m101l1","m110l1","m111l1"] #Comment for d
choose_belief_4 = ["m000l2","m001l2","m010l2","m011l2","m100l2","m101l2","m110l2","m111l2"] #Comment for d
choose_belief_5 = ["m000l3","m001l3","m010l3","m011l3","m100l3","m101l3","m110l3","m111l3"] #Comment for d
choose_belief_6 = ["m000l4","m001l4","m010l4","m011l4","m100l4","m101l4","m110l4","m111l4"] #Comment for d


random.seed(300)
# Assemble 100 cases randomly but with constraints
for ii in range(0,20):
	f = open('meta_orders.txt', 'w')
	select2 = random.randint(0,3)
	f.write(choose_belief_1[select2]+'\n')
	select2 = random.randint(0,1)
	f.write(choose_belief_2[select2]+'\n')
	select2 = random.randint(0,7)
	f.write(choose_belief_3[select2]+'\n')
	select2 = random.randint(0,7)
	f.write(choose_belief_4[select2]+'\n')
	select2 = random.randint(0,7)
	f.write(choose_belief_5[select2]+'\n')
	select2 = random.randint(0,7)
	f.write(choose_belief_6[select2]+'\n')
	f.close()
	child = pexpect.spawn('./timed_hri.jar')
	time.sleep(10)
	pexpect.signal.SIGINT
	f1 = open('coverage_robot.txt', 'a')
	f1.write('------------\n')
	f1.close()

#Separate tests in individual files
i = 1
for num,command in enumerate(open('output.txt','r')): 
	f = open('abstract_tests_rand300/abstract_test'+str(i)+'.txt', 'a')
	if re.search("-------",command):
		f.close()
		i = i+1
	else:
		f.write(command)
