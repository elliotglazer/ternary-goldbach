from pathlib import Path
from collections import defaultdict
from statistics import median
from hashlib import sha256
import json
p=Path(__file__).resolve().parent
rows=json.loads((p/'integer-groups.json').read_bytes())['bands']
log=(p/'norm02_bench.log').read_text().splitlines()
assert 'NORMAL_TRANSLATE_DONE' in log and (p/'norm02_bench.status').read_text().strip()=='0' and any(x.startswith('SLAB bad_last') for x in log)
run=defaultdict(dict); admit={}; setup={}; prep={}
for l in log:
    z=l.split()
    if z[:1]==['SLAB'] and z[1]!='bad_last':
        i,n=map(int,z[1].split('_')); run[i,n][int(z[2])]=list(map(float,z[3:]))
    if z[:1]==['PREP']: prep[int(z[1])]=float(z[2])
    if z[:1]==['ADMIT']: admit[int(z[1])]=float(z[2])
    if z[:1]==['SETUP'] and z[1]!='bad_last': setup[tuple(map(int,z[1].split('_')))]=float(z[2])
res=[]
for b in rows:
    i=b['band']; counts={128:b['groups']-b['last_groups'],129:b['last_groups']}; marginal=[0.]*3; full=[0.]*3
    for n,N in counts.items():
        for k in range(3):
            core=run[i,n][k][0]; control=run[i,0][k][0]
            marginal[k]+=(core-control)*N/3600
            full[k]+=(admit[i]+setup[i,n]+sum(run[i,n][k]))*N/3600
    res.append(dict(band=i,group_count=b['groups'],last_groups=b['last_groups'],marginal_trials=marginal,standalone_trials=full,sec128=[run[i,128][k][0]-run[i,0][k][0] for k in range(3)], sec129=[run[i,129][k][0]-run[i,0][k][0] for k in range(3)]))
def totals(key):
    return dict(median=sum(median(b[key]) for b in res), min=sum(min(b[key]) for b in res), max=sum(max(b[key]) for b in res),by_trial=[sum(b[key][k] for b in res) for k in range(3)])
out=dict(bands=res,marginal=totals('marginal_trials'),standalone=totals('standalone_trials'),groups=sum(b['groups'] for b in rows),cells=sum(b['cells'] for b in rows),last=sum(b['last_groups'] for b in rows))
out['all_unassigned_preparation_hours']=sum(max(0,prep[b['band']]-sum(setup[b['band'],n] for n in (0,128,129)))*b['groups']/3600 for b in rows)
out['native_candidate_hours']=json.loads((p/'native-price.json').read_bytes())['total']
out['hashes']={s:sha256((p/s).read_bytes()).hexdigest() for s in ('norm02_bench.log','integer-samples.txt','integer-groups.json','normbench.sml','NormalizedTranslateScript.sml')}
(p/'price.json').write_text(json.dumps(out,indent=2))
print({k:v for k,v in out.items() if k not in ('bands','hashes')})
