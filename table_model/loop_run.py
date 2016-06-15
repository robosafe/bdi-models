#!/usr/bin/env python

import pexpect
import time
import re

# Tree of belief decisions to write into meta agent
choose_belief_1 = ["leg1","leg2","leg3","leg4"] #For a-c
choose_belief_2 = ["","bored"]
choose_belief_3 = ["m110l1","m111l1"] #Comment for d
choose_belief_4 = ["m110l2","m111l2"] #Comment for d
choose_belief_5 = ["m110l3","m111l3"] #Comment for d
choose_belief_6 = ["m110l4","m111l4"] #Comment for d

# Try all environment combinations once
for i1 in choose_belief_1:
	for i2 in choose_belief_2:
		for i3 in choose_belief_3:#Comment for d
			for i4 in choose_belief_4:#Comment for d
				for i5 in choose_belief_5:#Comment for d
					for i6 in choose_belief_6:#Comment for d
						f = open('meta_orders.txt', 'w')
						f.write(i1+'\n')
						f.write(i2+'\n')
						f.write(i3+'\n') #Comment for d
						f.write(i4+'\n') #Comment for d
						f.write(i5+'\n') #Comment for d
						f.write(i6+'\n') #Comment for d
						f.close()
						child = pexpect.spawn('./timed_hri.jar')
						time.sleep(5)
						pexpect.signal.SIGINT
						f1 = open('coverage_robot.txt', 'a')
						f1.write('------------\n')
						f1.close()

#Separate tests in individual files
i = 1
for num,command in enumerate(open('output.txt','r')): 
	f = open('abstract_tests/abstract_test'+str(i)+'.txt', 'a')
	if re.search("-------",command):
		f.close()
		i = i+1
	else:
		f.write(command)
