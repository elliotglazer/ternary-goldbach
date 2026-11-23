from pathlib import Path
import re,json
p=Path(__file__).resolve().parent
def times(label):
    rows={}
    for n,c,w in re.findall(r'^(\w+) cpu=([.\d]+) wall=([.\d]+)',(p/(label+'_bench.log')).read_text(),re.M):
        rows[n]=float(c)
    assert 'RS_DONE' in (p/(label+'_bench.log')).read_text()
    return rows
scalar=[times(l) for l in ['rs06','rs07']]
import sys
mesh=[times(l) for l in sys.argv[1:]]
a=json.loads((p/'mesh-slab-mapping.json').read_text())
slab_batches=(a['dense_grid_sites']+63)//64+a['extra_sites']//64
summary=dict(scalar=scalar,mesh=mesh,slab_batches=slab_batches)
for m in mesh:
    m['cpu_per_site_64']=m['mesh64']/64
    m['cpu_per_zero_64_observed_window']=m['mesh64']/20
    m['modeled_slab_cpu_per_zero']=m['mesh64']*slab_batches/10812
    m['modeled_high_rate_full_hours']=m['modeled_slab_cpu_per_zero']*248008025/3600
(p/'timings.json').write_text(json.dumps(summary,indent=2));print(summary)
