import numpy as np
import matplotlib.pyplot as plt

data=np.loadtxt("collected_data.txt")

procs=data[:,0]
avgs=data[:,1]
stds=data[:,2]

plt.errorbar(procs, avgs, yerr=stds, marker=".", linestyle="-", capsize=3)
plt.xlabel("MPI Threads")
plt.ylabel("Execution Time (s)")
plt.show()
