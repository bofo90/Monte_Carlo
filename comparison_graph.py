import matplotlib as matl
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import pylab as P
from math import *

matl.rc('xtick', labelsize=14) 
matl.rc('ytick', labelsize=14) 

data = np.loadtxt("data/rsq_3D_noPERM.dat", skiprows=1)

N = data[:,0]
rsq_noPERM = data[:,1]
rsq_noPERM_err = data[:,2]

data = np.loadtxt("data/rsq_BETA092.dat", skiprows=1)

rsq_PERM = data[:,1]
rsq_PERM_err = data[:,2]

fig = plt.figure(1)
ax = fig.add_subplot(1,1,1)
ax.set_yscale('log')
ax.set_xscale('log')

data = np.loadtxt("data/npoly_BETA092.dat", skiprows=1)
pop = data[:,1]

fit_param = np.polyfit(np.log(N[2:50]-1), np.log(rsq_PERM[2:50]), 1)
print fit_param

rsq_teo = np.exp([fit_param[1] + 2*0.588*log(y-1) for y in N[2:]])
ax.plot(N[2:], rsq_teo, 'r-', linewidth = 1.5)

ax.errorbar(N[2:], rsq_PERM[2:], yerr=rsq_PERM_err[2:], fmt='-', color = 'g')
ax.errorbar(N[2:], rsq_noPERM[2:], yerr=rsq_noPERM_err[2:], fmt='--', color = 'k')
ax.plot(N[2:], pop[2:], '-o')

plt.xlabel('N', fontsize=18)
plt.ylabel(r'$<R^2>$', fontsize=18)
legend = ['Expected', 'PERM', 'Rosenbluth']
plt.legend(legend, loc='lower right', fontsize=16)

plt.show()