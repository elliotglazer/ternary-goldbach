from pathlib import Path
import json
from fractions import Fraction
from hashlib import sha256
here=Path(__file__).resolve().parent
out={}
for q in [7689,7283]:
    d=here/str(q)
    rows=json.loads((d/"fractions.json").read_text()); counts=json.loads((d/"counts.json").read_text())
    checks={}
    for pair,variants in counts["counts"].items():
        checks[pair]={}
        for v,guards in variants.items():
            checks[pair][v]={}
            for g in guards:
                checks[pair][v][g["extra"]]={name:{"delta":g["U_minus_K"][name],"strict_pass":Fraction(m)>0,"two_unit_pass":Fraction(m)>-1} for name,m in g["exact_margin"].items()}
    parity={}
    for r in rows:
        main=json.loads((d/"spectrum.json").read_text())["main"]*4096
        lookup=dict(tuple(map(int,s.split())) for s in (d/f"signs-{r['label']}.tsv").read_text().splitlines())
        parity[r["label"]]=(lookup[0]==lookup[1] and lookup[main]==lookup[main-1] and (r["main"]["brackets"]%2)==(lookup[0]!=lookup[main]))
    out[q]=dict(raw=sum(r["raw"] for r in rows),dense=sum(r["dense"] for r in rows),labels=rows,discovery=counts["channels"],guards=checks,endpoint_parity=parity,hashes={p.name:sha256(p.read_bytes()).hexdigest() for p in [d/"fractions.json",d/"counts.json",d/"spectrum.json",d/"grid.json",d/"stencils.json"]})
    print(q,out[q]["raw"],out[q]["dense"],[(k, [(h,round(x["moderate"]["delta"],4)) for h,x in v["fixed"].items()]) for k,v in checks.items()])
(here/"results.json").write_text(json.dumps(out,indent=2))
