import numpy as np
import matplotlib.pyplot as plt
import scipy.optimize as opt
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("data_file", metavar="data_file")
args = parser.parse_args()

data = np.loadtxt(args.data_file)
sizes = data[:,0]
times = data[:,1] / 2

pars,pconv = opt.curve_fit(lambda x,k,m: k*x + m, sizes, times)

print("Bandwidth: {:.4e} (s)".format(1/pars[0]))
print("Latency: {:.4e} (s)".format(pars[1]))

f = pars[0]*sizes + pars[1]
plt.plot(sizes, times)
plt.xlabel("Message Size (b)")
plt.ylabel("Execution Time (s)")
plt.show()
