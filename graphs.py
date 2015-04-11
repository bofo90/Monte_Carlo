import matplotlib as matl
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import pylab as P
from math import *

file_end = "2DPE100"

data = np.loadtxt("data/rsq_"+file_end+".dat", skiprows=1)

N = data[:,0]
rsq = data[:,1]
rsq_err = data[:,2]

fig = plt.figure(1)
ax = fig.add_subplot(1,1,1)

fit_param = np.polyfit(np.log(N[2:190]-1), np.log(rsq[2:190]), 1)
print fit_param
ax.set_yscale('log')
ax.set_xscale('log')

ax.errorbar(N[1:], rsq[1:], yerr=rsq_err[1:], fmt='o')
rsq_teo = np.exp([-0.5+fit_param[1] + 2*0.75*log(y-1) for y in N[2:]])
ax.plot(N[2:], rsq_teo, 'r-')

data = np.loadtxt("data/rsq_2DRR100.dat", skiprows=1)
rsq = data[:,1]
rsq_err = data[:,2]

ax.errorbar(N[1:], rsq[1:], yerr=rsq_err[1:], fmt='o')

fig = plt.figure(2)
ax = fig.add_subplot(1,1,1)

data = np.loadtxt("data/gyr_"+file_end+".dat", skiprows=1)

N = data[:,0]
rsq = data[:,1]

fit_param = np.polyfit(np.log(N[2:190]-1), np.log(rsq[2:190]), 1)
print fit_param

ax.plot(N[1:], rsq[1:], '-o')
rsq_teo = np.exp([fit_param[1] + fit_param[0]*log(y-1) for y in N[2:]])

ax.plot(N[2:], rsq_teo, 'r-')
ax.set_yscale('log')
ax.set_xscale('log')


plt.show()
