import matplotlib.pyplot as plt
import numpy as np

data = np.loadtxt("summary.txt", delimiter=" ", skiprows=1)
threads = data[:, 0]
bandwidths = data[:, 1]
errors = data[:, 2]

plt.errorbar(x=threads, y=bandwidths/1000,yerr=errors/1000, barsabove=True, fmt="-", marker=".", capsize=2)
plt.xlabel("# of Threads")
plt.ylabel("Bandwidth (GB/s)")
plt.show()
