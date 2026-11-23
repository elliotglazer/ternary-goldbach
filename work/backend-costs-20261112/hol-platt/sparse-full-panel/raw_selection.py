from pathlib import Path
import sys,json,importlib.util
from fractions import Fraction as F
from math import ceil
here=Path(__file__).resolve().parent
d=here/sys.argv[1]
sys.path.insert(0,str(d))
from spectrum import parameters,LABELS
from grid import HALO,GRID_BITS
from repair import rationals,SUB
def load(name,path):
    spec=importlib.util.spec_from_file_location(name,path)
    mod=importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod
st=load("stencils",here.parent/"full-height-count/stencils.py")
st.run()
pack=load("pack",here.parent/"sparse-count/prepare.py")
main,last,*_=parameters()
cut,end=main*SUB,last*SUB
lines=iter((d/"stencils.txt").read_text().splitlines())
kernels={}
for _ in range(int(next(lines))):
    k,r,o,den,e=map(int,next(lines).split())
    kernels[k]=(r,o,den,e,list(map(int,next(lines).split())))
jobs={}
for _ in range(int(next(lines))):
    label,t,k,s=map(int,next(lines).split())
    next(lines)
    jobs[label,t]=k
a,_,sample=rationals(json.loads((d/"spectrum.json").read_bytes()))
rad=ceil((a+sample)*(1<<GRID_BITS))
rows=[]
for label in LABELS:
    raw=list(map(int,(d/f"grid-{label}.txt").read_text().splitlines()))
    signs=[tuple(map(int,line.split())) for line in (d/f"signs-{label}.tsv").read_text().splitlines()]
    lookup=dict(signs)
    m,_,mr=pack.region(signs,0,cut,raw,False)
    g,_,gr=pack.region(signs,cut,end,raw,True)
    pts={t for t,s in m+g}|{0,1,cut-1,cut,end}
    used={t//SUB+HALO for t in pts if t%SUB==0}
    direct=len(used)
    for t in pts:
        if t%SUB==0:
            assert lookup[t]*raw[t//SUB+HALO]>rad+1
        else:
            r,o,den,e,w=kernels[jobs[label,t]]
            j=t//SUB+HALO+1-r//2
            assert lookup[t]*sum(v*x for v,x in zip(w,raw[j:j+r],strict=True))>den*(e+5)
            used.update(range(j,j+r))
    rows.append(dict(label=label,raw=len(used),dense=len(raw),direct=direct,stencil_only=len(used)-direct,offgrid=sum(t%SUB!=0 for t in pts),fraction=len(used)/len(raw),main=mr,aux=gr))
(d/"fractions.json").write_text(json.dumps(rows,indent=2))
print(rows)
