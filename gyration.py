import matplotlib as matl
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import pylab as P
from math import *

fig = plt.figure()
ax = Axes3D(fig)

data = np.loadtxt("data/position_BETA094.dat")

x = data[0:249,0]
y = data[0:249,1]
z = data[0:249,2]

x_mean = np.sum(x)/250
y_mean = np.sum(y)/250
z_mean = np.sum(z)/250

ax.plot(x, y, z, '-o')
ax.scatter(x_mean, y_mean, z_mean, color = 'r')

X = np.arange(-5, 5, 0.25)
xlen = len(X)
Y = np.arange(-5, 5, 0.25)
ylen = len(Y)
X, Y = np.meshgrid(X, Y)
R = np.sqrt(X**2 + Y**2)
Z = np.sqrt(25-R**2)

surf = ax.plot_surface(X, Y, Z)

# X = np.arange(-4, 4, 0.25)
# Y = np.arange(-4, 4, 0.25)
# X, Y = np.meshgrid(X, Y)
# R = np.sqrt(X ** 2 + Y ** 2)
# Z = np.sin(R)


# ax.contourf(X, Y, Z, zdir='x', offset=-4, cmap=plt.cm.hot)
# ax.contour(X, Y, Z, zdir='x', offset=-4, colors='k')
# ax.contourf(X, Y, Z, zdir='y', offset=4, cmap=plt.cm.hot)
# ax.contour(X, Y, Z, zdir='y', offset=4, colors='k')
# ax.contourf(X, Y, Z, zdir='z', offset=-1, cmap=plt.cm.hot)
# ax.contour(X, Y, Z, zdir='z', offset=-1, colors='k')

plt.show()