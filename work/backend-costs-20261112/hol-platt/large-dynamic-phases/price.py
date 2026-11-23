import json
from pathlib import Path
p=Path(__file__).resolve().parent
groups={}
for line in (p/'dp02.log').read_text().splitlines():
    if line.startswith('DYNAMIC_ROW '):
        _,q,j,n,a,b,c=line.split()
        v=groups.setdefault(q,[0,0.,0.,0.])
        for i,x in enumerate((int(n),float(a),float(b),float(c))):
            v[i]+=x
cols=list(map(sum,zip(*groups.values())))
rates={'dynamic':sum(cols[1:])/cols[0],'dynamic_no_parse':sum(cols[2:])/cols[0]}
s=[]
if (p/'ds02.status').exists() and (p/'ds02.status').read_text().strip()=='0':
    s=[l.split() for l in (p/'ds02.log').read_text().splitlines() if l.startswith('STATIC ')]
    rates['static']=sum(float(l[3]) for l in s)/sum(int(l[2]) for l in s)
out=dict(dynamic_conductors=groups,dynamic_total=cols,static=[sum(int(l[2]) for l in s),sum(float(l[3]) for l in s)],seconds_per_unit=rates,
         scenarios=[dict(extra=e,qj=n,dynamic_core_hours=n*rates['dynamic']/3600) for e,n in ((0,1528006797),(167,1548948597),(320,1568134797),(640,1608262797))])
if s:out['static_hours_4333246843']=4333246843*rates['static']/3600
(p/'price.json').write_text(json.dumps(out,indent=2))
print(out)
