import matplotlib as matl
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import pylab as P
from math import *
from matplotlib import cm

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
data = np.loadtxt("data/position_BETA094.dat")

a = 30

x_mean_av = 0
y_mean_av = 0
z_mean_av = 0
r_g = 0
i = 0

for j in "bgrcmy":
    x = data[i*250:i*250+249,0]
    y = data[i*250:i*250+249,1]
    z = data[i*250:i*250+249,2]

    x_mean = np.sum(x)/250
    y_mean = np.sum(y)/250
    z_mean = np.sum(z)/250

    x_mean_av += x_mean
    y_mean_av += y_mean
    z_mean_av += z_mean

    x = x - x_mean
    y = y - y_mean
    z = z - z_mean

    print sqrt(np.sum((x)**2 + (y)**2 + (z)**2)/len(x))

    r_g += sqrt(np.sum((x-x_mean)**2 + (y-y_mean)**2 + (z-z_mean)**2)/len(x))

    ax.plot(x, y, z, color = j)
    ax.plot(y, z, -a, color = 'k', zdir='x')
    ax.plot(x, z, a, color = 'k', zdir='y')
    ax.plot(x, y, -a, color = 'k', zdir='z')

    i +=1

x_mean_av = x_mean_av/6
y_mean_av = y_mean_av/6
z_mean_av = z_mean_av/6
r_g = r_g/6
r_g_all = sqrt(102.38837884919118)
# x = data[0:249,0]
# y = data[0:249,1]
# z = data[0:249,2]

# x_mean = np.sum(x)/250
# y_mean = np.sum(y)/250
# z_mean = np.sum(z)/250

# r_g = sqrt(np.sum((x-x_mean)**2 + (y-y_mean)**2 + (z-z_mean)**2)/len(x))
u, v = np.mgrid[0:2*np.pi:30j, 0:np.pi:15j]
x_sph = r_g_all*np.cos(u)*np.sin(v)
y_sph = r_g_all*np.sin(u)*np.sin(v)
z_sph = r_g_all*np.cos(v)

ax.plot_wireframe(x_sph, y_sph, z_sph, color="k", alpha = 0.5)
ax.contourf(x_sph, y_sph, z_sph, zdir='x', offset=-a, cmap=cm.coolwarm, zorder=-10, alpha = 0.5)
# ax.plot(y, z, -26, color = 'k', zdir='x')
ax.contourf(x_sph, y_sph, z_sph, zdir='y', offset=a, cmap=cm.coolwarm, zorder=-10, alpha = 0.5)
# ax.plot(x, z, 9, color = 'k', zdir='y')
ax.contourf(x_sph, y_sph, z_sph, zdir='z', offset=-a, cmap=cm.coolwarm, zorder=-10, alpha = 0.5)
# ax.plot(x, y, -18, color = 'k', zdir='z')

# ax.scatter(x_mean, y_mean, z_mean, color = 'r')

# ax.plot(x, y, z, '-o')

ax.set_xlim(-a, a)
ax.set_ylim(-a, a)
ax.set_zlim(-a, a)

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