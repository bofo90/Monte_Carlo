import matplotlib as matl
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import pylab as P
from math import *

file_end = "PERM_2D"

fig = plt.figure(3)
ax = fig.add_subplot(111, projection='3d')

data = np.loadtxt("data/position_"+file_end+".dat", skiprows=0)
i = 0
for j in "bgrcmy":
    x = data[i*250:i*250+249,0]
    y = data[i*250:i*250+249,1]
    z = data[i*250:i*250+249,2]

    #ax.scatter(x, y, z, color = j)
    ax.plot(x, y, z, color = j, alpha = 0.5)

    i += 1

ax.plot(x, y, z, color = 'b', alpha = 0.5)

plt.show()