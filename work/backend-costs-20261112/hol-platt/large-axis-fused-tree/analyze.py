import json
from collections import defaultdict
from statistics import median
from pathlib import Path
p=Path(__file__).resolve().parent; d=defaultdict(lambda:defaultdict(lambda:defaultdict(list)))
for l in (p/"v02.log").read_text().splitlines():
 if l.startswith("FAST "):
  _,m,n,q,cap,w,r,_,s,_=l.split(); d[n][int(m)][int(r)].append(float(s))
rows={}
for n,modes in d.items():
 rates={m:(median(rs[max(rs)])-median(rs[0]))/max(rs) for m,rs in modes.items()}
 rows[n]=dict(baseline=rates[0],fused=rates[2],ratio=rates[2]/rates[0])
print(rows);(p/"repeated.json").write_text(json.dumps(rows,indent=2))
