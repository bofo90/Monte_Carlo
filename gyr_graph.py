import matplotlib as matl
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import pylab as P
from math import *

file_end = "2DPE100"

fig = plt.figure(1)
ax = fig.add_subplot(1,1,1)

data = np.loadtxt("data/gyr_"+file_end+".dat", skiprows=1)

N = data[:,0]
rsq = data[:,1]

fit_param = np.polyfit(np.log(N[2:50]), np.log(rsq[2:50]), 1)
print fit_param

ax.plot(N[2:], rsq[2:], 'k-x')
rsq_teo = np.exp([fit_param[1] + 2*0.75*log(y) for y in N[2:]])
ax.plot(N[2:], rsq_teo, 'r-')
ax.set_yscale('log')
ax.set_xscale('log')

plt.ylabel(r'$<R_g^2>$', fontsize=18)
plt.xlabel('N', fontsize=16)

legend = ['PERM', 'Fit with '+r'$\nu = 0.75$']
plt.legend(legend, loc='lower right', fontsize=16)

plt.show()