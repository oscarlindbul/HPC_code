#!/usr/bin/env python3

import os
import sys
import matplotlib.pyplot as plt

MAX_CPU_THREADS=12

thread = []
mean = []
derivation = []

with open("data.txt") as f:
	lines = f.readlines()
	for l in lines:
		x = l.split()
		if(len(x)<3):
			continue
		thread.append(int(x[0]))
		mean.append(float(x[1]))
		derivation.append(float(x[2]))

speedup = []
label = []

for i in range(len(thread)-1):
	label.append(thread[i+1])
	speedup.append(mean[0]/mean[i+1])

speedup1 = []
label1= []
for i in range(len(label)):
	if label[i] <= MAX_CPU_THREADS:
		label1.append(label[i])
		speedup1.append(speedup[i])

plt.plot(label1, speedup1, ".-")
plt.xlabel("Number of threads")
plt.ylabel("Speed Up")
plt.xlim(1, MAX_CPU_THREADS)
plt.ylim(1, MAX_CPU_THREADS)
plt.xticks(label1)

plt.savefig("plot.pdf");
plt.show()

