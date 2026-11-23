from pathlib import Path
import json
from collections import Counter
from math import prod
p=Path(__file__).resolve().parent
work=p.parents[2]
f=work/"qrh-campaign/agents/integration/transform_structural_manifest_20261111.json"
doc=json.loads(f.read_bytes())
res={}
for guard in (0,167,320,640):
 totals=Counter(); by=Counter(); hist=Counter(); byshape=Counter(); alternate=Counter()
 for c,phi,chars,H,j,axes,_ in doc["conductors"]:
  h=j+41+guard
  assert prod(n for n,q in axes)==phi and prod(n-(n//q if q else 0) for n,q in axes)==chars
  n,q=axes[-1] if axes else (1,0)
  cost=h*chars
  def cls(n):
   return "regular" if n>=32 else ("identity" if n==1 else ("short_radix2" if n&(n-1)==0 else "short_other"))
  name=cls(n); by[name]+=cost; byshape[f"{n},{q}"]+=cost; hist[name]+=1
  eligible=[(m,k) for m,k in axes if m>=32]
  alternate["has_any_regular"]+=cost*bool(eligible)
  alternate["regular_terminal_power2"]+=cost*(n>=32 and n&(n-1)==0)
  alternate["regular_terminal_even"]+=cost*(n>=32 and n%2==0)
  alternate["last_pivot_nonzero"]+=cost*bool(q)
  alternate["regular_last_pivot_nonzero"]+=cost*(n>=32 and bool(q))
  totals["outputs"]+=cost; totals["conductors"]+=1
  if n>=32: totals["eligible_slices"]+=h*(chars//(n-(n//q if q else 0)))
 res[guard]=dict(totals=totals,by=by,conductors=hist,by_shape=byshape,other=alternate)
 print(guard,totals,by,alternate,flush=True)
(p/"terminal.json").write_text(json.dumps(res,indent=2))
