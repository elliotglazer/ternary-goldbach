from pathlib import Path
import json
p=Path(__file__).resolve().parent
exec((p/'summarize.py').read_text().split('scalar=')[0])
s=times('rs07');a=times('mesh05');b=times('meshcompact01'); partial=(p/'meshlarge01_bench.log').read_text(); b.update({n:float(v) for n,v in re.findall(r'^(mesh128|mesh256) cpu=([.\d]+)',partial,re.M)})
# 64 contiguous blocks plus 1 endpoint; repair runs each stay inside their window.
N=248008025
q=64*b['mesh512']+s['sample0']+113*a['mesh64']+23*b['mesh128']+3*b['mesh256']+b['mesh512']
result=dict(dense_work_sec=64*b['mesh512']+s['sample0'],repair_work_sec=q-(64*b['mesh512']+s['sample0']),slab_work_sec=q,cpu_sec_per_zero=q/10812,ceiling_rate_cpu_hours=N*q/10812/3600,mesh64=a,extended=b)
(p/'extended-model.json').write_text(json.dumps(result,indent=2));print(result)

