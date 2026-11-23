"""Exploratory floating-point compact-smoothing quadrature; not a certificate.

These samples do not bound the actual etaPlus transform or the continuous
height supremum. See MINOR_ENERGY_QRH.md for the separate analytic result.
"""
import os
os.environ['OPENBLAS_NUM_THREADS']='1'
import numpy as np
import math
from numpy.polynomial.legendre import leggauss
x0=4.9e26
L=math.log(x0)
nodes,weights=leggauss(512)
t=nodes+1
u=np.log(t)
base=t**(.875+5)*(2-t)**6*np.exp(-(t-1)**2)*weights
for gam in [0,2.39,6.373,9.067,10,11,12,13,14,14.1,15,16,18,20,25,30,40,50]:
    z=base*np.exp(1j*gam*u)
    m=z.sum(); mp=(z*u).sum()
    w=2*1.125/(1.125**2+gam**2)+2*1.875/(1.875**2+gam**2)
    k=2*abs(m+mp/L)/w
    print(gam, 'M',abs(m),'M+Mp/L',abs(m+mp/L),'quartet_kernel',k,'rel_error_bound',.07*x0**(-.125)*k)
print('L',L,'xscale',x0**(-.125),'required kernel for old advertised integral', (5e-8-5.3e-7/L)/(.07*x0**(-.125)))
print('Aup error',(1.6*368+1000/1.6)/200**4+368/200**4/2-2e-9)
print('Bup error',(.4*368+60/.4)/200**4+.37*368/200**4+2.3e-7)
