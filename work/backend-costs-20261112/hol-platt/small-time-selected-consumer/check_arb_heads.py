from actual import *
from flint import acb
from time import process_time
ctx.prec=336;ctx.threads=1
vals=[list(map(int,s.split()))[1:] for s in (src/'coefficients.tsv').open()]
out=[]
for col,l in enumerate(labels):
    st=process_time();X=[acb(0)]*N
    for j,v in enumerate(vals):
        a=acb(arb((v[2*col],-256)),arb((v[2*col+1],-256)));X[-j]=a
        if j:X[j]=a.conjugate()
    F=acb.dft(X);del X
    maxfrac=0;count=0;worst=0
    for row in (p/f'selected-{l}.tsv').open():
        j,*_,e,h=map(int,row.split());u=1<<e;f=F[(j-128)%N];assert f.imag.contains(0)
        diff=abs(f.real*(1<<220)-h*u);assert diff<=u,(l,j,diff,u)
        z=float(diff/u)
        if z>maxfrac:maxfrac=z;worst=j
        count+=1
    del F
    out.append(dict(label=l,checked=count,max_fraction_of_head_unit=maxfrac,worst_slot=worst,cpu=process_time()-st));print(out[-1],flush=True)
    (p/'arb_all_heads.json').write_text(json.dumps(out,indent=2))
