"""Exact enclosures of cost-model ratios, not function/zero evaluations."""
from fractions import Fraction as F
from math import isqrt
from pathlib import Path
import json

H0=10**8
def sqrtbox(n):
    d=10**18
    k=isqrt(n*d*d)
    return F(k,d),F(k+1,d)
def logbox(n):
    k=n.bit_length()-1
    x=F(n,2**k)
    def atanh_log(x):
        z=(x-1)/(x+1);p=70
        s=2*sum(z**(2*j+1)/F(2*j+1) for j in range(p))
        e=2*z**(2*p+1)/F(2*p+1)/(1-z*z)
        return s,s+e
    a,b=atanh_log(F(2));c,d=atanh_log(x)
    lo,hi=k*a+c,k*b+d
    den=10**30
    return F(lo.numerator*den//lo.denominator,den),F(-((-hi.numerator*den)//hi.denominator),den)
def w32(n):
    a,b=sqrtbox(n);c,d=sqrtbox(H0)
    return n*a-H0*d,n*b-H0*c
def wlog(n):
    a,b=logbox(n);c,d=logbox(H0)
    return n*(a-1)-H0*(d-1),n*(b-1)-H0*(c-1)
def ratio(ref,target,fun):
    a,b=fun(ref);c,d=fun(target)
    return a/d,b/c
def boxstr(a,b,den=1000):
    return [str(F(a.numerator*den//a.denominator,den)),str(F(-((-b.numerator*den)//b.denominator),den))]

rows=[]
for ref in (3*10**12,3000175332800):
    for Q in (1,2,4,8,16,32,47,48,50):
        H=4*10**10*Q
        lin=F(ref-H0,H-H0)
        lo,hi=ratio(ref,H,w32)
        ll,lu=ratio(ref,H,wlog)
        # r = coefficient target fraction / linear target fraction
        rlo,rhi=lin/hi,lin/lo
        mixture={}
        for s in (F(0),F(1,4),F(1,2),F(3,4),F(1)):
            mixture[str(s)]=boxstr(lin/(1-s+s*rhi),lin/(1-s+s*rlo))
        assert lo>lin and ll>lin
        rows.append(dict(reference=ref,Q=Q,H=H,linear_reduction=boxstr(lin,lin),
            coefficient_H32_reduction=boxstr(lo,hi),integral_log_reduction=boxstr(ll,lu),
            coefficient_relative_to_linear=boxstr(rlo,rhi,10**6),
            mixture_reductions_by_reference_coefficient_share=mixture))
out=dict(status='PASS_EXACT_MODEL_RATIO_ENCLOSURES',lower_reused_height=H0,rows=rows,
    scope='Ratios of specified scalar work integrals only; no historical runtime fit, parameter validation, sign success or proof-backend cost.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps([r for r in rows if r['reference']==3*10**12],indent=2))
