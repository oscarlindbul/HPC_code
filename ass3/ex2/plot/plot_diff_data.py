import numpy as np
import matplotlib.pyplot as plt

implementations = ["Linear_Blocking", "Tree_Blocking", "Linear_Nonblock"]

comparison = implementations[0]
comp_data = np.loadtxt("../"+comparison+"/collected_data.txt")
comp_avgs=comp_data[:,1]
for imp in implementations[1:]:
	data=np.loadtxt("../"+imp+"/collected_data.txt")
	procs=data[:,0]
	avgs=data[:,1]-comp_avgs
	stds=data[:,2]

	plt.plot(procs, avgs, marker=".", linestyle="-", label=imp)

plt.plot(procs, [0]*len(procs), linestyle="--")
plt.xlabel("MPI Threads")
plt.ylabel("Execution Time (s)")
plt.legend()
plt.show()
