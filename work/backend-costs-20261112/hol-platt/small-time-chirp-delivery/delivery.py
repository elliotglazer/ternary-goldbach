"""Exact dyadic seed brackets and integer working-grid recurrence."""
from math import isqrt
from pathlib import Path
from collections import defaultdict
from fractions import Fraction as F
from time import process_time
import json,sys,hashlib
p=Path(__file__).resolve().parent
def ceildiv(a,b):return -((-a)//b)
def seed(n,G):
    lo,hi,sl,sh=0,0,G,G
    history=[(lo,hi,sl,sh)]
    for _ in range(1,n.bit_length()-1):
        l=isqrt((G*G+G*lo)//2)
        u=isqrt((G*G+G*hi)//2)+1
        h=ceildiv(G*sh,2*l);s=(G*sl)//(2*u)
        assert 2*l*l<=G*G+G*lo and G*G+G*hi<=2*u*u
        assert 2*s*u<=G*sl and G*sh<=2*h*l
        lo,hi,sl,sh=l,u,s,h;history.append((l,u,s,h))
    return history
def mid(v):
    l,u,s,h=v;x=(l+u)//2;y=(s+h)//2
    return (x,y),max(x-l,u-x)+max(y-s,h-y)
def prod(a,b,G):
    x,y=a;u,v=b
    return (x*u-y*v+G//2)//G,(x*v+y*u+G//2)//G
def check(n,pbits,steps,lookup):
    q=pbits+76;G=1<<q;scale=1<<(q-pbits)
    hs=seed(n,G);r,E=mid(hs[-1]);delta,D=mid(hs[-2]);z=(G,0)
    assert (1+2*D)*steps+E<G
    # Before step j the ratio error in grid units is <= E+j*(2D+1).
    # If accumulated phase error <= G, the approximate phase has modulus <=2.
    # Hence the next phase error increases by at most 1+2 times that ratio error.
    def bound(j):return j*(1+2*E)+(2*D+1)*j*(j-1)
    assert bound(steps)<G
    radius=0; bad=[];saved={}; start=process_time()
    for j in range(steps+1):
        if j in lookup:
            vv=[]
            for t in z:
                a=(t-radius+scale//2)//scale;b=(t+radius+scale//2)//scale
                if a!=b:bad.append((j,a,b))
                vv.append((t+scale//2)//scale)
            saved[j]=tuple(vv)
        if j<steps:z=prod(z,r,G);r=prod(r,delta,G);radius+=1+2*(E+j*(2*D+1))
    assert radius==bound(steps)
    return saved,dict(n=n,p=pbits,q=q,steps=steps,queried=len(lookup),seed_error=E,ratio_step_seed_error=D,
           final_working_units=radius,ambiguous=len(bad),first_ambiguous=bad[:2],recurrence_cpu=process_time()-start,seeds=hs)
def main():
    rows={};prev=p.parent/'small-time-selected-consumer'
    for l in (3,6667,11,9091):
        rows[l]=[(int(v[0]),int(v[4]),int(v[5])) for line in (prev/f'selected-{l}.tsv').open() if (v:=line.split())]
    wanted={abs(j-128) for r in rows.values() for j,x,y in r}
    table,res=check(524288,240,max(wanted),wanted)
    for rr in rows.values():
        for j,x,y in rr:assert table[abs(j-128)]==(x,y)
    res['head_sites']=sum(map(len,rows.values()));res['per_channel']={k:len(v) for k,v in rows.items()}
    (p/'c10000-delivery.json').write_text(json.dumps(res,indent=2));print({k:v for k,v in res.items() if k!='seeds'})
if __name__=='__main__':main()
