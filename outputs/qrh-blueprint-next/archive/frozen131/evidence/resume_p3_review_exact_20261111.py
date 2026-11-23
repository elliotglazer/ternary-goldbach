"""Independent exact audit of the recovered P3 floor-kernel certificate.
Reads rational coefficients only; no LP output or floating decision is used.
Does not prove the analytic floor/factorial bridge in Lean.
"""
from fractions import Fraction as Q
from pathlib import Path
import json,hashlib
p=Path(__file__).resolve().parent.parent/'prime-estimates'/'resume_p3_exact_kernel_20261111.json'
raw=p.read_bytes(); data=json.loads(raw)
d=int(data['d']);m=int(data['m'])
assert(d,m)==(24,72)
c={int(j):Q(v) for j,v in data['coeff'].items()}
assert all(1<=j<=m for j in c)
assert sum((v*Q(j,d) for j,v in c.items()),Q(0))==1
points={Q(0),Q(1),Q(d)}
for j in range(1,m+1):
    for i in range(1,j+1): points.add(Q(d*i,j))
points=sorted(points)
def K(u):return sum((v*((j*u)//d) for j,v in c.items()),Q(0))
for u in points:
    assert K(u)<=(0 if u<1 else u),(u,K(u))
for lo,hi in zip(points,points[1:]):
    mid=(lo+hi)/2
    assert K(mid)==K(lo)
    assert K(mid)<=(0 if mid<1 else mid)
    assert K(mid+24)==K(mid)+24
# Proved atanh-series enclosure for log(q), with binary range reduction.
def smalllog(q):
    z=(q-1)/(q+1); n=40
    assert 0<=z<=Q(1,3)
    lo=sum((2*z**(2*j+1)/Q(2*j+1) for j in range(n)),Q(0))
    err=2*z**(2*n+1)/(Q(2*n+1)*(1-z*z))
    return lo,lo+err
L2,U2=smalllog(Q(2))
def logbox(q):
    q=Q(q);k=0
    while q<1:q*=2;k-=1
    while q>2:q/=2;k+=1
    lo,hi=smalllog(q)
    return (lo+k*L2,hi+k*U2) if k>=0 else(lo+k*U2,hi+k*L2)
Slo=Q(0);Shi=Q(0)
for j,v in c.items():
    a=Q(j,d);lo,hi=logbox(a);w=v*a
    Slo+=w*(lo if w>=0 else hi)
    Shi+=w*(hi if w>=0 else lo)
B=sum(map(abs,c.values()),Q(0))
assert Slo>Q('.26659')>Q('.2665')
assert B<Q('5.51')
assert logbox(10000)[1]<Q('9.211')
assert logbox(3)[1]<Q('1.1')
assert logbox(3)[0]-logbox(2)[1]/2>Q('.74')
error=Q('5.51')*Q('11.311')/10000
constant=1-Q('.2665')+error+Q(1,10000)
assert constant==Q('.739832361')<Q('.74')
print('PASS_INDEPENDENT_EXACT_AUDIT')
print('certificate_sha256',hashlib.sha256(raw).hexdigest())
print('support',len(c),'breakpoints_with_zero',len(points))
print('B_exact',B)
print('certified_S_lower',Q('.26659'))
print('certified_final_integer_constant',constant)
print('No LP floats, no Lean proof, no finite-small-range certificate replay.')
