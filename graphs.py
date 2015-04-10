import matplotlib as matl
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import pylab as P
from math import *

file_end = "2DRR100"

data = np.loadtxt("data/rsq_"+file_end+".dat", skiprows=1)

N = data[:,0]
rsq = data[:,1]
rsq_err = data[:,2]

fig = plt.figure(1)
ax = fig.add_subplot(1,1,1)

fit_param = np.polyfit(np.log(N[2:40]-1), np.log(rsq[2:40]), 1)
print fit_param
ax.set_yscale('log')
ax.set_xscale('log')

ax.errorbar(N[1:], rsq[1:], yerr=rsq_err[1:], fmt='o')
rsq_teo = np.exp([fit_param[1] + 2*0.75*log(y-1) for y in N[2:]])
ax.plot(N[2:], rsq_teo, 'r-')

fig = plt.figure(2)
ax = fig.add_subplot(1,1,1)

data = np.loadtxt("data/gyr_"+file_end+".dat", skiprows=1)

N = data[:,0]
rsq = data[:,1]

ax.plot(N[1:], rsq[1:], '-o')
ax.set_yscale('log')
ax.set_xscale('log')

#fig = plt.figure(3)
#ax = fig.add_subplot(111, projection='3d')

#data = np.loadtxt("data/position_"+file_end+".dat", skiprows=0)

#i = 0
#for j in "bgrcmy":
#    x = data[i*250:i*250+249,0]
#    y = data[i*250:i*250+249,1]
#    z = data[i*250:i*250+249,2]

    #ax.scatter(x, y, z, color = j)
#    ax.plot(x, y, z, color = j, alpha = 0.5)

#    i += 1

#ax.set_xlabel('X axis')
#ax.set_ylabel('Y axis')
#ax.set_zlabel('Z axis')


plt.show()
