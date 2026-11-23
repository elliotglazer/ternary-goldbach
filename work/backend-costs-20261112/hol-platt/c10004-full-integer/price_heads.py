"""Time native production and validation of all h1 head states against the input."""
import csv
import json
import sys
from pathlib import Path
from math import isqrt
from time import perf_counter,process_time
here=Path(__file__).resolve().parent
source=here.parent/'c10004-p20-source'
sys.path.insert(0,str(source))
from produce import dyadic,nearest
from flint import ctx,arb,acb
ctx.prec=200
ctx.threads=1
def state(x):
    m=isqrt((1<<196)//x)
    assert m*m*x<=1<<196<(m+1)**2*x
    step=dyadic(acb(0,-5*arb(x).log()/64).exp(),122)
    return [nearest((m<<22)*t,1<<122) for t in step]
t=perf_counter()
c=process_time()
with (source/'h1-rawhead.tsv').open() as f:
    heads=list(csv.DictReader(f,delimiter='\t'))
u,v=state(10004)
for row in heads:
    a=int(row['a'])
    x,y=state(a)
    z=[nearest(10004*t,1<<140) for t in (u*x+v*y,u*y-v*x)]
    assert z==[int(row['re']),int(row['im'])]
    exact=(arb(a)/10004)**acb(-arb(1)/2,-arb(5)/64)
    assert abs(acb(*z)/2**100-exact)<arb(1)/2**85
print(json.dumps(dict(wall=perf_counter()-t,cpu=process_time()-c,matched=len(heads))))
