import matplotlib as matl
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import pylab as P
from math import *

matl.rc('xtick', labelsize=14) 
matl.rc('ytick', labelsize=14) 

data = np.loadtxt("data/rsq_2DRR100.dat", skiprows=1)

N = data[:,0]
rsq_noPERM = data[:,1]
rsq_noPERM_err = data[:,2]

data = np.loadtxt("data/rsq_2DPE100.dat", skiprows=1)

rsq_PERM = data[:,1]
rsq_PERM_err = data[:,2]

fig = plt.figure(1)
ax = fig.add_subplot(1,1,1)
ax.set_yscale('log')
ax.set_xscale('log')

data = np.loadtxt("data/npoly_2DPE100.dat", skiprows=1)
pop = data[:,1]

fit_param = np.polyfit(np.log(N[2:40]-1), np.log(rsq_PERM[2:40]), 1)
print fit_param

rsq_teo = np.exp([-0.2+fit_param[1] + 2*.75*log(y-1) for y in N[2:]])

l1 = ax.errorbar(N[2:], rsq_PERM[2:], yerr=rsq_PERM_err[2:], fmt='-', color = 'g')
l2 = ax.errorbar(N[2:], rsq_noPERM[2:], yerr=rsq_noPERM_err[2:], fmt='--', color = 'k')
l3 = ax.plot(N[2:], rsq_teo, 'r-', linewidth = 1.5)
plt.ylabel(r'$<R^2>$', fontsize=18)
legend = ['PERM', 'Rosenbluth', 'Expected']
plt.legend(legend, loc='lower right', fontsize=16)
# plt.ylim([1,1000])

ax2 = fig.add_subplot(111, sharex=ax, frameon=False)
l4 = ax2.plot(N[2:], pop[2:], '-o')
ax2.yaxis.tick_right()
ax2.yaxis.set_label_position("right")
ax2.set_yscale('log')
ax2.set_xscale('log')
plt.ylabel("PERM Population", fontsize=18)
plt.ylim([100,11000])

plt.xlabel('N', fontsize=18)

plt.show()