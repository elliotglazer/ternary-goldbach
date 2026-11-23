"""Rational bounds for interpolating the actual tilted Hardy function."""
from fractions import Fraction as F
from math import factorial, comb, log2
from pathlib import Path
import json

def bound(q,V,theta,order):
    W=q*F(V)/theta
    # e > sum_{j=0}^12 1/j!, every bound uses exact rational arithmetic.
    e=sum(F(1,factorial(j)) for j in range(13))
    # Centered stencil on [0,1]: paired factors (j+x)(j+1-x)
    # attain their maxima together at x=1/2, j=0,...,order/2-1.
    product=1
    for j in range(order//2):
        product *= (j+F(1,2))**2
    spacing=F(5,64)
    def candidate(k):
        M=2*W**(k+1)*factorial(k-1)*(order/((2*k-1)*e))**order
        return M*spacing**order*product/factorial(order)
    best,k=min((candidate(k),k) for k in range(1,order+1))
    return dict(order=order,k=k,bound=str(best),log2_bound=log2(float(best)))

rows=[]
for theta in (2,4,8,64,80):
    row=dict(q=265800,V=505,theta=theta,bounds=[bound(265800,505,theta,n) for n in (8,12,16,24,32,48,64,96)])
    rows.append(row)
    print(theta,[round(v["log2_bound"],2) for v in row["bounds"]])
Path(__file__).with_name("low-tilt-moment.json").write_text(json.dumps(rows,indent=2)+"\n")
