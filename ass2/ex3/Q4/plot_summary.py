import matplotlib.pyplot as plt
import numpy as np
import tabulate

data = np.loadtxt("summary.txt", delimiter=" ", skiprows=1)
threads = data[:, 0]
times = data[:, 1]
errors = data[:, 2]

fig = plt.figure()
ax = fig.gca()
ax.errorbar(x=threads, y=times, yerr=errors, barsabove=True, fmt="-", marker=".", capsize=2, label="Critical")
ax.set_xlabel("# of Threads")
ax.set_ylabel("Runtime (s)")
plt.show()
