import matplotlib.pyplot as plt
import numpy as np
import tabulate

data = np.loadtxt("summary.txt", delimiter=" ", skiprows=1)
threads = data[:, 0]
critical_times = data[:, 1]
critical_errors = data[:, 2]
parallel_times = data[:, 3]
parallel_errors = data[:, 4]

fig = plt.figure()
ax = fig.gca()
ax.errorbar(x=threads, y=critical_times, yerr=critical_errors, barsabove=True, fmt="-", marker=".", capsize=2, label="Critical")
ax.errorbar(x=threads, y=parallel_times,yerr=parallel_errors, barsabove=True, fmt="-", marker=".", capsize=2, label="No Critical")
ax.set_xlabel("# of Threads")
ax.set_ylabel("Runtime (s)")
ax.legend()
plt.show()

print(tabulate.tabulate(data, tablefmt="latex", headers=["Threads", "Runtime (Critical)", "Deviation (Critical)", "Runtime (Parallel)", "Deviation (Parallel)"], floatfmt=[".0f", ".6f", ".3e", ".6f", ".3e"]))
