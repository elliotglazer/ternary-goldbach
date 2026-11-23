"""Original h0 inverse-root and h1 grid120 state update with interval-certified step122."""
import csv,hashlib
from math import isqrt
from pathlib import Path
from flint import arb,acb,ctx
from produce import dyadic,nearest

base=Path(__file__).resolve().parent
ctx.prec=200
ctx.threads=1


def state(x):
    m=isqrt((1<<196)//x)
    assert m*m*x<=1<<196<(m+1)**2*x
    step=dyadic(acb(0,-5*arb(x).log()/64).exp(),122)
    val=[nearest((m<<22)*v,1<<122) for v in step]
    return [x,m,*step,*val]


source=list(csv.DictReader((base.parent/"c10004-reference/h1.tsv").open(),delimiter="\t"))
states={x:state(x) for x in [10004]+[int(row["a"]) for row in source]}
with (base/"h1-head-states.tsv").open("w",newline="") as file:
    w=csv.writer(file,delimiter="\t",lineterminator="\n")
    w.writerow(["x","m98","step_re122","step_im122","re120","im120"])
    w.writerows(states.values())
u,v=states[10004][-2:]
with (base/"h1-rawhead.tsv").open("w",newline="") as file:
    w=csv.writer(file,delimiter="\t",lineterminator="\n")
    w.writerow(["index","a","re","im"])
    for row in source:
        a=int(row["a"])
        x,y=states[a][-2:]
        z=[nearest(10004*t,1<<140) for t in (u*x+v*y,u*y-v*x)]
        actual=(arb(a)/10004)**acb(-arb(1)/2,-arb(5)/64)
        assert abs(acb(*z)/2**100-actual)<arb(1)/2**85
        w.writerow([row["index"],a,*z])
print(hashlib.sha256((base/"h1-rawhead.tsv").read_bytes()).hexdigest())
