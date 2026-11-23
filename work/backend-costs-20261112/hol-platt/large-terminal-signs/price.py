from pathlib import Path
from statistics import median
import json,hashlib
d=Path(__file__).resolve().parent
p=d/"t07price.log"; assert (d/"t07price.status").read_text().strip()=="0"
r={}
for l in p.read_text().splitlines():
 if l.startswith("TERMINAL "):
    _,b,n,m=l.split()
 if l.startswith("JOIN_EVAL "):
    r.setdefault(b,{}).setdefault((int(n),m),[]).append(float(l.split()[2]))
out={}
for b,rows in r.items():
    costs={m:[v/8/4602*1e6 for v in rows[8,m]] for m in ("true","false")}
    gross=median(costs["true"]); control=median(costs["false"]); delta=gross-control
    out[b]=dict(eight_pass_us=costs,gross_us=gross,checksum_us=control,net_us=delta,one_conductor_family_sensitivity_h=delta*39241839619586/3.6e9,gross_h=gross*39241839619586/3.6e9,
          four_pass_net_us=(rows[4,"true"][0]-rows[4,"false"][0])/4/4602*1e6)
report=dict(rows=out,hashes={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in [p,d/"LargeTerminalScript.sml",d/"LargeTerminalPriceScript.sml",d/".hol/objs/LargeTerminalPriceTheory.dat"]})
(d/"price.json").write_text(json.dumps(report,indent=2))
print(out)
