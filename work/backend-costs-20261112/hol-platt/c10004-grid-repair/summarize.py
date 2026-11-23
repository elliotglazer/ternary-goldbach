import json
from pathlib import Path
p=Path(__file__).resolve().parent
def read(name):
    return json.loads((p/name).read_bytes())
a=read('adaptive.json')
b=read('mid-adaptive.json')
lo=read('low-receipt.json')
hi=read('high-receipt.json')
m=read('mid-receipt.json')
assert m['twice_grid_changes']==hi['total_changes']+2*m['hidden_pairs']
summaries=[]
for v in (lo,hi):
    ns=v['nodes']
    summaries.append(dict(indices=v['indices'],changes=v['total_changes'],
        counts={s:sum(n['counts'].get(s,0) for n in ns) for s in ('1','-1','0')},
        min_grid_1e12=min((n['minimum'][0],n['j'],n['minimum'][1]) for n in ns),
        direct_checks=len(v['checks']),direct_hidden=sum(c['hidden_pair'] for c in v['checks']),
        cpu=v['cpu'],node_cpu=sum(n['cpu'] for n in ns)))
summary=dict(coarse=summaries,high_source_cpu=a['inclusive']['cpu'],
        high_source_cold_cpu=a['cold_head_and_step_setup']['cpu'],
        high_first_jet_cpu=a['nodes'][0]['setup']['cpu'],
        high_remaining_jet_cpu=sum(n['setup']['cpu'] for n in a['nodes'][1:]),
        high_head_and_polynomials_cpu=sum(n['produce']['cpu'] for n in a['nodes']),
        initial_high_cpu=a['inclusive']['cpu']+hi['cpu'],
        midpoint_source_cpu=b['inclusive']['cpu'],midpoint_transform_cpu=m['cpu'],
        midpoint_inconclusive=m['inconclusive'],midpoint_count=15*2301,
        midpoint_changes=m['twice_grid_changes'],same_sign_intervals=15*2301-hi['total_changes'],
        hidden_pairs=m['hidden_pairs'],example=m['examples'][:3])
(p/'summary.json').write_text(json.dumps(summary,indent=2))
print(json.dumps(summary,indent=2))
