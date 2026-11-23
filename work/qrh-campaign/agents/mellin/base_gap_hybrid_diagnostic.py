"""Exploratory quadrature for fixed-approximant eta2 bounds, not certified.

The source pointwise theorem still depends on separate Platt replacements.
Only selected moduli are evaluated. No statement about all moduli is proved.
"""
import os
os.environ['OPENBLAS_NUM_THREADS']='1'
import math
import numpy as np
from numpy.polynomial.legendre import leggauss

def totient(n):
    out=n; k=n; p=2
    while p*p<=k:
        if k%p==0:
            out-=out//p
            while k%p==0:k//=p
        p+=1
    if k>1:out-=out//k
    return out

def R(x,t):
    return .27125*np.log(1+np.log(4*t)/(2*np.log(9*x**(1/3)/(2.004*t))))+.41415

def integrated(q,delta=None,order=256):
    a,b=.001,8.
    t,v=leggauss(order)
    w=(a+b)/2+(b-a)/2*t
    wt=(b-a)/2*v*w*w*np.exp(-w*w/2)
    if delta is None:delta=600000/(49*q)
    r=np.maximum(q,w*q*abs(delta)/4)
    f=q/totient(q)
    ell=np.log(2*r)
    val=((R(w*1e25,2*r)*ell+.8764)*np.sqrt(f)+2.526)/np.sqrt(2*r)
    val+=(f*(13/4*ell+7.82)+13.66*ell+37.55)/r+3.8*(w*1e25)**(-1/6)
    tail=17*(a**3/3+(b+1/b)*math.exp(-b*b/2))
    # At fixed r the expression is A*sqrt(f)+B*f+C.
    A=np.dot(wt,(R(w*1e25,2*r)*ell+.8764)/np.sqrt(2*r))
    B=np.dot(wt,(13/4*ell+7.82)/r)
    C=np.dot(wt,2.526/np.sqrt(2*r)+(13.66*ell+37.55)/r+3.8*(w*1e25)**(-1/6))+tail
    return dict(q=q,phi=totient(q),ratio=f,delta=delta,A=A,B=B,C=C,bound=A*math.sqrt(f)+B*f+C)

for q in [1,101,1009,5003,10007,20011,30011,50021,75011,100003,149993,2310,30030,60060,90090,120120,150000]:
    row=integrated(q)
    print('MIN_DELTA',row)
for q in [1009,10007,30030,100003,149993,150000]:
    print('MAX_DELTA',integrated(q,600000/q))
