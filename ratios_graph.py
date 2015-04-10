import matplotlib as matl
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import pylab as P
from math import *

betas = [0.92, 0.94]
legend = []

fig = plt.figure(1)
ax = fig.add_subplot(1,1,1)
ax.set_xscale('log')

for beta in betas:
	print beta
	suffix = "BETA" + "{:0>3d}".format(int(100*beta))
	data = np.loadtxt("data/rsq_"+suffix+".dat", skiprows=1)

	N = data[:,0]
	rsq = data[:,1]

	data = np.loadtxt("data/gyr_"+suffix+".dat", skiprows=1)

	gyr = data[:,1]

	ratio = np.divide(rsq[2:], gyr[2:])
	#ratio = np.divide(gyr[2:], N[2:])

	legend_str = "{:.3f}".format(100*beta)
	legend.append(legend_str)

	#plt.plot(np.divide(1,np.log(N[2:])), ratio)
	ax.plot(N[2:], ratio)

plt.show()





