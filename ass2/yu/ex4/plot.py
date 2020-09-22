#!/usr/bin/env python3

import os
import sys
import matplotlib.pyplot as plt

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

plt.plot(label, speedup, ".-")
plt.xlabel("Number of threads")
plt.ylabel("Speed Up")
plt.xlim(1, 32)
plt.ylim(1, 32)
plt.xticks(label)

plt.show()
plt.savefig("plot.pdf");
