"""Apply the frozen physical-interval weights and retain every test outcome."""
from collections import Counter,defaultdict
from fractions import Fraction as F
from hashlib import sha256
from math import sqrt
from pathlib import Path
import json

out=Path(__file__).resolve().parent
freeze=out.parents[2]/'backend-costs-20261112/hol-platt/guard-repricing/weighted-repair-panel.json'
raw=freeze.read_bytes()
assert sha256(raw).hexdigest()=='343e001fb602519fa59b487928ded5972a3e700475a0cb36a99dba97cde2f43e'
selection=json.loads(raw)['selection']
rows=[]
for i,req in enumerate(selection):
    p=out/f'{i:02d}-q{req["q"]}'
    state='pending'
    if (p/'status.json').exists(): state=json.loads((p/'status.json').read_bytes())['exit']
    r=dict(**req,status=state)
    if (p/'inclusive-rounded.json').exists():
        inc=json.loads((p/'inclusive-rounded.json').read_bytes())['rows']
        count=next(x for x in inc if x['guard']==640)
        assert count['labels']==[req['label'],req['inverse']]
        r.update(K=count['K'],moderate_excess=count['U_minus_K']['moderate'],Rumely_excess=count['U_minus_K']['Rumely'],
            moderate_pass=F(count['U_minus_K']['moderate'])<1,rumely_pass=F(count['U_minus_K']['Rumely'])<1)
    if (p/'short.json').exists():
        short=json.loads((p/'short.json').read_bytes())
        n=short['coarse_intervals']; j=short['jobs']; h=short['hits'].get('12,16',0)
        assert n==2*((req['height']*64+4)//5+640)
        r.update(cells=n,jobs=j,short12_hits=h,fallback12=j-h,unresolved32=len(short['unresolved']),orders=short['first_order_at_16_bits'])
        r['source_cpu']=sum(json.loads((p/f).read_bytes())[k] for f,k in [('spectrum.json','cpu_seconds'),('grid.json','total_cpu'),('counts.json','total_cpu')])
        r['short_cpu']=short['short_cpu_seconds']
    rows.append(r)
summary=dict(rows=rows,complete=sum('jobs'in r for r in rows))
if summary['complete']==len(rows):
    weights={r['stratum']:r['weight'] for r in rows}
    mass=sum(weights.values())
    rates={}
    for kind in ['jobs','fallback12','unresolved32']:
        strata=defaultdict(list)
        for r in rows: strata[r['stratum']].append(F(r[kind],r['cells']))
        estimates={k:sum(x)/2 for k,x in strata.items()}
        total=sum(weights[k]*v for k,v in estimates.items())
        se=sqrt(sum((weights[k]*float(x[0]-x[1])/2)**2 for k,x in strata.items()))
        rates[kind]=dict(projected_total=float(total),per_million=float(total*10**6/mass),design_SE_total=se)
    summary.update(weights=weights,mass=mass,weighted_rates=rates,jobs=sum(r['jobs'] for r in rows),
        cells=sum(r['cells'] for r in rows),short12_hits=sum(r['short12_hits'] for r in rows),
        unresolved32=sum(r['unresolved32'] for r in rows),moderate_pass=sum(r['moderate_pass'] for r in rows))
(out/'summary.json').write_text(json.dumps(summary,indent=2))
print(summary['complete'],[(r['q'],r['jobs'],r['short12_hits'],r['moderate_pass']) for r in rows if 'jobs' in r],summary.get('weighted_rates'))
