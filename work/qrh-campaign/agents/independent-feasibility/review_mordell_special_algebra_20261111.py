"""Exact exponential-polynomial checks for Mordell specializations.

Formal sums of (a+b sqrt2)*exp(i*pi*(q0+q1*v+q2*v²)).
Uses only exp(A+B), exp(i*pi)=-1, and sqrt2²=2; no sampling.
This proves algebra, not contour integrals or analytic convergence.
"""
from fractions import Fraction as Q
from pathlib import Path
import hashlib,json

def p(*x):return tuple(Q(x[i]) if i<len(x) else Q(0) for i in range(3))
def pa(a,b):return tuple(x+y for x,y in zip(a,b))
def ps(a,b):return pa(a,tuple(-v for v in b))
def pk(k,a):return tuple(k*v for v in a)
def pm(a,b):
    full=[sum(a[j]*b[i-j] for j in range(3) if 0<=i-j<3) for i in range(5)]
    assert full[3:]==[0,0]
    return tuple(full[:3])
def cm(a,b):return (a[0]*b[0]+2*a[1]*b[1],a[0]*b[1]+a[1]*b[0])
def canon(ex,c):
    n=ex[0].numerator//ex[0].denominator
    sg=-1 if n%2 else 1
    return (ex[0]-n,ex[1],ex[2]),tuple(sg*x for x in c)
def clean(d):return {k:v for k,v in d.items() if v!=(0,0)}
def add(*ds):
    out={}
    for d in ds:
        for k,v in d.items():out[k]=tuple(x+y for x,y in zip(out.get(k,(Q(0),Q(0))),v))
    return clean(out)
def neg(d):return {k:tuple(-x for x in v) for k,v in d.items()}
def sub(a,b):return add(a,neg(b))
def mul(a,b):
    out={}
    for x,c in a.items():
        for y,d in b.items():
            k,v=canon(pa(x,y),cm(c,d));out=add(out,{k:v})
    return out
def E(ex):
    k,v=canon(ex,(Q(1),Q(0)));return {k:v}
def C(a,b=0):return clean({p():(Q(a),Q(b))})
ONE=C(1);I=E(p(Q(1,2)));RT=C(0,1);IR=mul(I,RT)
def cos(ex):return mul(C(Q(1,2)),add(E(ex),E(pk(-1,ex))))
def sin(ex):return mul(C(-Q(1,2)),mul(I,sub(E(ex),E(pk(-1,ex)))))
def conj(a):
    out={}
    for ex,c in a.items():
        k,v=canon(pk(-1,ex),c);out=add(out,{k:v})
    return out
def subst(a,h):
    out={}
    for ex,c in a.items():
        new=pa(p(ex[0]),pa(pk(ex[1],h),pk(ex[2],pm(h,h))))
        k,v=canon(new,c);out=add(out,{k:v})
    return out
def gaussian(tau,x):
    pref=ONE if tau==1 else RT if tau==Q(1,2) else C(0,Q(1,2))
    return mul(pref,E(ps(p(Q(1,4)),pk(1/tau,pm(x,x)))))
checks={}
def check(k,a,b):
    for obj in (a,b):
        if isinstance(obj,dict):
            assert all(isinstance(q,Q) for ex,c in obj.items() for q in (*ex,*c))
        else:assert all(isinstance(q,Q) for q in obj)
    assert a==b,(k,a,b)
    checks[k]=True
v=p(0,1)
# Relation5 twice at tau1/2: a(x+1/2)*a(x)=exp(-4pi ix), and
# a(x+1/2)=i exp(-2pi ix).
aa=E(ps(p(-Q(1,2)),pk(2,v)))
ab=E(ps(p(-Q(1,2)),pk(2,pa(v,p(Q(1,2))))))
check('half_two_shift_multiplier',mul(aa,ab),E(pk(-4,v)))
check('half_two_shift_constant',ab,mul(I,E(pk(-2,v))))
# Half quotient numerator after clearing relation3/5.
g=gaussian(Q(1,2),v)
nh=add(I,E(pk(2,v)),neg(mul(E(pk(2,v)),g)))
dh=sub(E(pk(2,v)),E(pk(-2,v)))
check('half_elimination',mul(nh,sub(E(pk(-4,v)),ONE)),
      mul(dh,sub(sub(g,mul(I,E(pk(-2,v)))),ONE)))
# Parameter1 kernel9 at x=z+1/2, cleared denominators.
x=pa(v,p(Q(1,2)))
n1=mul(E(pk(2,x)),sub(ONE,gaussian(Q(1),x)))
d1=add(ONE,E(pk(2,x)))
nk=sub(E(v),E(pk(-1,pm(v,v))))
dk=sub(E(v),E(pk(-1,v)))
check('parameter1_kernel9',mul(n1,dk),mul(d1,nk))
# Parameter2 equation12, before conjugation.
x=ps(p(Q(1,2)),pk(2,v))
n2=sub(add(gaussian(Q(2),x),gaussian(Q(2),pa(x,p(1)))),ONE)
d2=sub(E(pk(-2,x)),ONE)
lhs=mul(mul(C(2),E(pa(p(-Q(1,8)),pk(2,pm(v,v))))),n2)
rhs=add(E(pa(p(-Q(1,8)),pa(pk(-2,v),pk(2,pm(v,v))))),
        mul(C(0,Q(1,2)),sub(E(v),E(pk(-1,v)))))
check('parameter2_equation12',mul(lhs,cos(pk(2,v))),mul(d2,rhs))
# Conjugate12 and set p=(1-v)/2, q=sqrt(pi)*v: equation13.
h=pk(Q(1,2),ps(p(1),v))
cr=subst(conj(rhs),h);cd=subst(cos(pk(2,v)),h)
angle=pa(p(Q(3,8)),pk(Q(1,2),pm(v,v)))
fnum=add(cos(angle),mul(I,sub(mul(RT,cos(pk(Q(1,2),v))),sin(angle))))
check('parameter2_equation13',mul(cr,cos(v)),mul(cd,fnum))
# Parameter1/2 at x=z/2+1/4: equation14.
h=pa(p(Q(1,4)),pk(Q(1,2),v))
left=mul(mul(IR,E(pk(-Q(1,2),v))),subst(nh,h))
check('half_equation14',mul(left,cos(v)),mul(subst(dh,h),fnum))
# Exponent after substitution in11, measured in units i*pi.
# 2p-1/2 +1/8-2p² =1/8 -(1-2p)²/2.
check('substitution11_constant',pa(ps(pk(2,v),p(Q(1,2))),ps(p(Q(1,8)),pk(2,pm(v,v)))),
      ps(p(Q(1,8)),pk(Q(1,2),pm(ps(p(1),pk(2,v)),ps(p(1),pk(2,v))))))
# Algebra15: at u=1/2+epsilon*w, constant phase prior Jacobian is−pi/8;
# epsilon supplies pi/4, leaving pi/8. This records the phase bookkeeping.
check('equation15_Jacobian_phase',mul(E(p(-Q(1,8))),E(p(Q(1,4)))),E(p(Q(1,8))))
out=dict(status='PASS_EXACT_MORDELL_SPECIAL_ALGEBRA',checks=checks,check_count=len(checks),
    script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    scope='Exact cleared-denominator algebra only; no contour, Gaussian integral, branch or holomorphy theorem proved by this script.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,indent=2))
