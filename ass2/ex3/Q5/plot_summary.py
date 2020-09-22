import matplotlib.pyplot as plt
import numpy as np
import tabulate

data1 = np.loadtxt("summary.txt", delimiter=" ", skiprows=1)
data2 = np.loadtxt("../Q4/summary.txt", delimiter=" ", skiprows=1)
threads = data1[:, 0]
times1 = data1[:, 1]
errors1 = data1[:, 2]
times2 = data2[:, 1]
errors2 = data2[:, 2]

fig = plt.figure()
ax = fig.gca()
ax.errorbar(x=threads, y=times1, yerr=errors1, barsabove=True, fmt="-", marker=".", capsize=2, label="No False Sharing")
ax.errorbar(x=threads, y=times2, yerr=errors2, barsabove=True, fmt="-", marker=".", capsize=2, label="False Sharing")
ax.set_xlabel("# of Threads")
ax.set_ylabel("Runtime (s)")
ax.legend()
plt.show()
