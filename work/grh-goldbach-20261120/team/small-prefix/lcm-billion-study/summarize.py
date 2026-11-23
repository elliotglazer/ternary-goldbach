import json,math
from pathlib import Path
d=Path(__file__).resolve().parent
p=d.parent
rd=lambda x:json.loads(x.read_text())
source={'control':rd(p/'compact-prefix/Power9.input.json')['write_inclusive_cpu'],'lcm':rd(d/'Power9.input.json')['write_inclusive_cpu']}
runs={}
for order in ('','reverse-'):
    for v in ('control','lcm'):
        a=rd(d/(order+v)/'9/receipt.json')
        runs[order+v]={k:a[k] for k in ('proof','audit','cpu_seconds','olean_bytes')}
        runs[order+v]['with_producer_cpu']=a['cpu_seconds']+source[v]
latest=1187.95
z=dict(comparison=runs,coverage=rd(d/'coverage.json'),producer_cpu=source,
       ten_billion_observed_cpu=latest,
       linear_scale_100_billion_hours=10*latest/3600,
       repeated_empirical_decade_factor=latest/120.45,
       repeated_empirical_decade_100_billion_hours=latest*(latest/120.45)/3600)
(d/'summary.json').write_text(json.dumps(z,indent=2))
for name,val in runs.items():
    print(name,val['with_producer_cpu'],val['proof'].get('max_rss_kib'))
