from pathlib import Path
from collections import defaultdict
import re,json,statistics,hashlib
p=Path(__file__).resolve().parent
rows={}
for f in sorted(p.glob('loop*_bench.log')):
    coll=defaultdict(dict)
    for l,k,n,m,c,w in re.findall(r'^(p?\d+),(\d+),(\d+),(\d+),([.\d]+),([.\d]+)',f.read_text(),re.M):
        coll[(l,int(k))][int(n),int(m)]=float(c)
    row=[]
    for (l,k),d in coll.items():
        if len(d)<4:continue
        base=(d[32,1]-d[1,1])/31;selected=(d[32,2]-d[1,2])/31
        row.append(dict(l=l,k=k,sites=64<<k,base=base,selected=selected,net=selected-base))
    if row:rows[f.name]=row
out={}
for key,rr in rows.items():
    for k in (0,2,4):
        for shape in ('genuine','periodic'):
            ds=[row for row in rr if row['k']==k and row['l'].startswith('p')==(shape=='periodic')]
            if len(ds)==4:
                out[f'{key}:{64<<k}:{shape}']=dict(mean_net=sum(d['net'] for d in ds)/4,paired_by_channel=[r['net'] for r in ds],mean_base=sum(d['base'] for d in ds)/4,mean_selected=sum(d['selected'] for d in ds)/4)
manifest={f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in sorted(p.glob('b-*.hex'))}
report=dict(rows=rows,summary=out,source_fixtures=manifest)
(p/'genuine-cost.json').write_text(json.dumps(report,indent=2));print(out)
