#!/usr/bin/env python

import pexpect
import time
import re
import random
import numpy as np 
import os
import math

# Tree of belief decisions to write into meta agent
choose_belief_1 = ["leg1","leg2","leg3","leg4"] #For a-c
choose_belief_2 = ["","bored"]
choose_belief_3 = ["m000l1","m001l1","m010l1","m011l1","m100l1","m101l1","m110l1","m111l1"] #Comment for d
choose_belief_4 = ["m000l2","m001l2","m010l2","m011l2","m100l2","m101l2","m110l2","m111l2"] #Comment for d
choose_belief_5 = ["m000l3","m001l3","m010l3","m011l3","m100l3","m101l3","m110l3","m111l3"] #Comment for d
choose_belief_6 = ["m000l4","m001l4","m010l4","m011l4","m100l4","m101l4","m110l4","m111l4"] #Comment for d
choose_all = choose_belief_2 +choose_belief_3 + choose_belief_4 + choose_belief_5 + choose_belief_6

#For new and old tests:
#Rewards: +10 if robot coverage points = max_test(robot coverage points) -> more code coverage per test or COVERAGE EXPLOITATION
#Rewards: +5 if robot coverage points = max_test(robot coverage points)- (1 or 2)
#Rewards: +10 if human coverage poins = max_test(human coverage points) -> more human coverage per test or COVERAGE EXPLOITATION
#Rewards: +5 if human coverage points = max_test(human coverage points)- (1 or 2)

max_robot = 0 #Max coverage points for robot
max_human = 0 #Max coverage points for human

qvalues = np.zeros((4+len(choose_all), len(choose_all)))

probabilities = np.ones((4+len(choose_all), len(choose_all)))
probabilities = (1/float(38)) * probabilities #Change to match choose_all length

alpha = 0.1
keeptime= time.time()
for ii in range(0,1000):
	random.seed(ii)
	f = open('meta_orders.txt', 'w')
	k = random.randint(0,10) #Length of belief sequence
	currentstate = random.randint(0,3)
	beliefs = [choose_belief_1[currentstate]]
	f.write(choose_belief_1[currentstate] +'\n')
	f.close()
	for i in range(0,k+1): 
		f = open('meta_orders.txt', 'a')
		reward = 0
		# Roulette to select next element from probabilities
		bring_probs = probabilities[currentstate]
		tempq = qvalues[currentstate]
		bring_probs = 100* bring_probs
		roulete = []
		for kk,jj in enumerate(bring_probs):
			for ll in range(0,int(round(jj))):
				roulete.append(choose_all[kk])
		select = random.randint(0,len(roulete)-1) #Choosing next state
		nextbelief = roulete[select]
		f.write(nextbelief +'\n')
		beliefs.append(nextbelief)
		f.close()
		#print beliefs
		# Run with the beliefs and collect data
		child = pexpect.spawn('./timed_hri.jar')
		time.sleep(5)
		pexpect.signal.SIGINT
		
		# Process robot coverage
		rcoverage = []
		#if  os.path.isfile("coverage_robot.txt"):
		for num,content in enumerate(open('coverage_robot.txt','r')):
			cpoint = re.split('\n',content)
			if cpoint[0] not in rcoverage:
				rcoverage.append(cpoint[0])
		if len(rcoverage) >= max_robot and len(rcoverage)> 1:
			max_robot = len(rcoverage)
			reward = reward + 100
		elif len(rcoverage) >= (max_robot-1) and len(rcoverage)> 1:
			reward = reward + 5
		elif len(rcoverage) >= (max_robot-2) and len(rcoverage)> 1:
			reward = reward + 1
			
		else:
			reward = reward - 100
		ff=open('coverage_robot.txt','w')
		ff.close()
		# Process human coverage
		coverage=[]
		#if os.path.isfile("coverage.txt"):
		for num,content in enumerate(open('coverage.txt','r')):
			cpoint = re.split('\n',content)
			if cpoint[0] not in coverage:
				coverage.append(cpoint[0])
		if len(coverage) >= max_human and len(coverage)> 0:
			max_human = len(coverage)
			reward = reward + 100
		elif len(coverage) >= (max_human-1) and len(coverage)> 0:
			reward = reward + 5
		elif len(coverage) >= (max_human-2) and len(coverage)> 0:
			reward = reward + 1
		else:
			reward = reward - 100
		ff = open('coverage.txt','w')
		ff.close()
		#if os.path.isfile("output.txt"):
		ff = open('output.txt','w')
		ff.close()
		
		# Next state becomes current state
		previousstate = currentstate
		for i,bel in enumerate(choose_all):
			if nextbelief == bel:
				currentstate = i+4
				columntoupdate = i 
		# Update rewards
		#print "reward:", reward
		tempnext = qvalues[currentstate]
		tempq[columntoupdate] = tempq[columntoupdate] + alpha*(reward + 0.1*max(tempnext)-tempq[columntoupdate])
		qvalues[previousstate] = tempq
		#print "local Q:", tempq
		#print "b", previousstate
		#print "b'", currentstate
		# Update probabilities
		sum_qs = 0 
		for oo in range(0,len(bring_probs)):
			sum_qs = sum_qs + math.exp(tempq[oo]/10.0)
		for oo in range(0,len(bring_probs)):
			bring_probs[oo] = math.exp(tempq[oo]/10.0)/sum_qs
		sum_probs = 0
		for oo in range(0,len(bring_probs)):
			sum_probs = sum_probs + bring_probs[oo]
		for oo in range(0,len(bring_probs)):
			bring_probs[oo] = bring_probs[oo]/sum_probs
		probabilities[previousstate] = bring_probs
		#print "local probs:", bring_probs
	alpha = 0.9* alpha
	f.close()
	print "Q:"
	for ij,num in enumerate(qvalues):
		print num

#print '\n'
#print "alpha:", alpha
#print "Q:"
#for ij,num in enumerate(qvalues):
#	print num
#print '\n'

#print "probs:"
#for ij,num in enumerate(probabilities):
#	print num

#print time.time()- keeptime

	
	


