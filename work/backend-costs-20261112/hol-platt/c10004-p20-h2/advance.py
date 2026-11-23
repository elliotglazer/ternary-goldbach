"""Advance the archived h1 grid120 states by exactly one retained grid122 step."""
import csv,hashlib,json
from pathlib import Path
from flint import arb,acb
from produce import pair_times,nearest,S,to_ball

HERE=Path(__file__).resolve().parent
Q=10004
parent=HERE.parent/"c10004-p20-source"
path=parent/"h1-head-states.tsv"
raw=path.read_bytes()
h1hash=hashlib.sha256(raw).hexdigest()
states={}
errors=[]
with (HERE/"h2-head-states.tsv").open("w",newline="") as file:
    w=csv.writer(file,delimiter="\t",lineterminator="\n")
    w.writerow(("x","step_re122","step_im122","prev_re120","prev_im120","re120","im120"))
    for row in csv.DictReader(raw.decode().splitlines(),delimiter="\t"):
        x=int(row["x"])
        assert x not in states
        sr,si=int(row["step_re122"]),int(row["step_im122"])
        prev=(int(row["re120"]),int(row["im120"]))
        val=pair_times(prev,sr,si,1<<122)
        truth=arb(x)**(-S)
        err=abs(to_ball(val,120)-truth)
        assert err<arb(1)/2**96
        errors.append(float(err.upper()))
        states[x]=val
        w.writerow((x,sr,si,*prev,*val))
assert len(states)==4801
source=HERE.parent/"c10004-reference/h2.tsv"
u,v=states[Q]
worst=0.
with source.open() as inp,(HERE/"h2-rawhead.tsv").open("w",newline="") as file:
    w=csv.writer(file,delimiter="\t",lineterminator="\n")
    w.writerow(("index","a","re","im"))
    for row in csv.DictReader(inp,delimiter="\t"):
        a=int(row["a"])
        x,y=states[a]
        val=tuple(nearest(Q*t,1<<140) for t in (u*x+v*y,u*y-v*x))
        err=abs(to_ball(val,100)-(arb(a)/Q)**(-S))
        assert err<arb(1)/2**85
        worst=max(worst,float(err.upper()))
        w.writerow((row["index"],a,*val))
(HERE/"head-receipt.json").write_text(json.dumps(dict(h1_state_sha256=h1hash,steps=4801,
        max_state_error=max(errors),max_head_error=worst),indent=2)+"\n")
