import numpy as np
import matplotlib.pyplot as plt

data=np.loadtxt("data.txt")
data_s=np.loadtxt("data_small.txt")

plt.plot(data[:,0], data[:,1], marker=".", label="CPU")
plt.plot(data[:,0], data[:,2], marker=".", label="GPU with mem")
plt.plot(data[:,0], data_s[:,2], marker=".", label="GPU without mem")

plt.xscale("log")
plt.yscale("log")
plt.xlabel("Array Size")
plt.ylabel("Execution Time (ms)")
plt.legend()
plt.show()
