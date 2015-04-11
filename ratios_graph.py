import matplotlib as matl
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import pylab as P
from math import *

betas = [0.92, 0.94, 0.96, 0.98]
legend = []

fig = plt.figure(1)
ax = fig.add_subplot(1,1,1)

matl.rc('xtick', labelsize=14) 
matl.rc('ytick', labelsize=14) 

for beta in betas:
	suffix = "BETA" + "{:0>3d}".format(int(100*beta))
	data = np.loadtxt("data/rsq_"+suffix+".dat", skiprows=1)

	N = data[:,0]
	rsq = data[:,1]

	data = np.loadtxt("data/gyr_"+suffix+".dat", skiprows=1)

	gyr = data[:,1]

	# ratio = np.divide(rsq[5:119], gyr[5:119])
	ratio = np.divide(gyr[5:], N[5:])

	legend_str = r'$\epsilon/k_B T$' + " = "+ "{:.3f}".format(0.25*beta)
	legend.append(legend_str)

	# ax.plot(np.divide(1,np.log(N[5:119])), ratio)
	ax.plot(N[5:], ratio)
	plt.legend(legend, loc='upper right', fontsize=16)
	# ax.plot(N[2:], ratio)

ax.set_xscale('log')
ax.set_yscale('log')
	
# plt.ylabel(r'$<R_g^2>/N$', fontsize=18)
plt.ylabel(r'$<R^2>/<R_g^2>$', fontsize=16)
plt.xlabel(r'$1/\log(N)$', fontsize=16)

plt.show()





