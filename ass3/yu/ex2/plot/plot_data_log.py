import numpy as np
import matplotlib.pyplot as plt

implementations = ["Linear_Blocking", "Tree_Blocking", "Linear_Nonblock", "Gather", "Reduce"]

for imp in implementations:

	data=np.loadtxt("../"+imp+"/collected_data.txt")
	procs=data[:,0]
	avgs=data[:,1]
	stds=data[:,2]

	plt.errorbar(procs, avgs, yerr=stds, marker=".", linestyle="-", capsize=3)

plt.xlabel("MPI Threads")
plt.ylabel("Execution Time (s)")
plt.legend(implementations)
plt.yscale("log")
plt.show()
