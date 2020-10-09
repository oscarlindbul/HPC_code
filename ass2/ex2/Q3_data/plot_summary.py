import matplotlib.pyplot as plt
import numpy as np

files = ["Q3dynamic", "Q3guided", "Q3static"]
labels = ["Dynamic", "Guided", "Static"]
for f,label in zip(files, labels):
    data = np.loadtxt(f + "/summary.txt", delimiter=" ", skiprows=1)
    threads = data[:, 0]
    bandwidths = data[:, 1]
    errors = data[:, 2]

    plt.errorbar(x=threads, y=bandwidths/1000,yerr=errors/1000, label=label)
plt.xlabel("# of Threads")
plt.ylabel("Bandwidth (GB/s)")
plt.legend()
plt.show()
