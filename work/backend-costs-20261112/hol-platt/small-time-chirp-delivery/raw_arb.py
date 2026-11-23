from pathlib import Path
import sys
p=Path(__file__).resolve().parent
sys.path.insert(0,str(p.parent/'small-time-selected-consumer'))
from actual import labels,src,N,J,project
from flint import arb,acb,ctx
import json,time
ctx.prec=336;ctx.threads=1
vals=[list(map(int,s.split()))[1:] for s in (src/'coefficients.tsv').open()];out=[]
for col,l in enumerate(labels):
    X=[acb(0)]*N
    for j,v in enumerate(vals):
        a=acb(arb((v[2*col],-256)),arb((v[2*col+1],-256)));X[-j]=a
        if j:X[j]=a.conjugate()
    F=acb.dft(X);del X
    n=0;peak=0.0
    for s in (p.parent/'small-time-selected-consumer'/f'selected-{l}.tsv').open():
        j,A,B,C,u,v,w,e,q=map(int,s.split());z=project(A,B,C,(u,v))
        assert q*(1<<e)<=z<(q+1)*(1<<e)
        assert abs(z)<1<<255 and 0<=q+(1<<(w-1))<1<<w
        f=F[(j-128)%N];err=abs(f.real*(1<<220)-z);assert err<=2
        peak=max(peak,float(err));n+=1
    print(l,n,peak,flush=True);out.append([l,n,peak]);del F
(p/'generated-raw.json').write_text(json.dumps(out,indent=2))
