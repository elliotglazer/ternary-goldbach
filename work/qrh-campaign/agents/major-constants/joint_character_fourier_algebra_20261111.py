"""Tiny exact finite-algebra diagnostics, not Gaussian or L-value evaluation."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

Z = (F(0), F(0))
ONE = (F(1), F(0))
I = (F(0), F(1))
def add(x,y): return (x[0]+y[0],x[1]+y[1])
def mul(x,y): return (x[0]*y[0]-x[1]*y[1],x[0]*y[1]+x[1]*y[0])
def scale(a,x): return (a*x[0],a*x[1])
def conj(x): return (x[0],-x[1])
def power(x,n):
    out=ONE
    for _ in range(n): out=mul(out,x)
    return out
def isum(xs):
    out=Z
    for x in xs: out=add(out,x)
    return out
def root(k): return power(I,k%4)

# Actual character coordinates modulo 5 with generator 2, order 4.
units=[pow(2,j,5) for j in range(4)]
coords={u:j for j,u in enumerate(units)}
assert set(units)=={1,2,3,4}
def chi(r,n): return Z if n%5==0 else root(r*coords[n%5])
def transform(row,r): return isum(mul(root(r*j),row[j]) for j in range(4))

checks=0
buckets={}
for a in [0,1]:
    row=[Z]*4
    for n in range(1,18):
        if n%5:
            # Arbitrary rational complex data, expressly not a Gaussian sample.
            value=scale(F(n**a),(F(n,n+1),F((-1)**n,n+2)))
            j=coords[n%5]
            row[j]=add(row[j],value)
    buckets[a]=row
    for r in [1,2,3]:
        direct=isum(mul(chi(r,n),scale(F(n**a),(F(n,n+1),F((-1)**n,n+2)))) for n in range(1,18))
        assert transform(row,r)==direct
        assert transform([conj(x) for x in row],(-r)%4)==conj(transform(row,r))
        checks+=2

# Source reciprocity has separate W and exponent factors; finite reordering
# remains valid for arbitrary scalar factors, so exact rational data suffice.
freqs=[-2,-1,0,1]
W={1:I,2:(F(3,5),F(4,5)),3:(F(5,13),F(-12,13))}
for a in [0,1]:
    rows={k:[add(x,(F(k+3,j+2),F(a+k,7))) for j,x in enumerate(buckets[a])] for k in freqs}
    pref={k:(F(k+4,9),F(a-k,11)) for k in freqs}
    for r in [1,2,3]:
        if r%2!=a: continue
        for t in range(4):
            character_first=isum(mul(root(k*t),mul(pref[k],mul(W[r] if k<0 else ONE,transform(rows[k],(-r)%4 if k<0 else r)))) for k in freqs)
            plus=[isum(mul(root(k*t),mul(pref[k],rows[k][j])) for k in freqs if k>=0) for j in range(4)]
            minus=[isum(mul(root(k*t),mul(pref[k],rows[k][j])) for k in freqs if k<0) for j in range(4)]
            time_first=add(transform(plus,r),mul(W[r],transform(minus,(-r)%4)))
            assert character_first==time_first
            checks+=1

# Critical-line corollary only: epsilon^2 W=1 implies epsilon W=conj epsilon.
eps=(F(3,5),F(4,5))
w=power(conj(eps),2)
assert mul(power(eps,2),w)==ONE
assert mul(eps,w)==conj(eps)
checks+=2

for N,L in [(4,0),(4,1),(8,2)]:
    M=(2*L+1)*N//2
    indices=range(-M,M)
    radii={r:F(r+1,7) for r in range(M+1)}
    assert sum((radii[abs(n)] for n in indices),F(0)) == radii[0]+2*sum((radii[r] for r in range(1,M)),F(0))+radii[M]
    assert len(set(abs(n) for n in indices))==M+1
    checks+=2

out={'scope':'Finite rational complex algebra only; no Gaussian, Gauss sum, FFT, L-value or spectral data.',
     'conductor':5,'generator':2,'primitive_labels':[1,2,3],
     'checks_passed':checks,'status':'PASS'}
p=Path(__file__)
p.with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,indent=2))
