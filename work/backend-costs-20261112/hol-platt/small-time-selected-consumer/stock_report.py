from pathlib import Path
import json,re,statistics
p=Path(__file__).resolve().parent
out={}
for lab in ('sel05','mask01','bias01'):
    f=p/(lab+'_bench.log')
    if not f.exists():continue
    data=[s.split(',') for s in f.read_text().splitlines() if re.match(r'^\d+,\d+,\d+,',s)];out[lab]=dict(rows=data)
    if lab=='sel05':continue
    ratios={};times={}
    for l,d,m,cpu,wall in data:times.setdefault((l,d),{})[int(m)]=float(cpu)
    if len(times)==8 and all(len(v)==3 for v in times.values()):
        for mode in [1,2]:
            xs=[v[mode]-v[0] for v in times.values()];total=sum(xs)
            ratios[str(mode)]=dict(matched_total_cpu=total,mean_per_physical_tile=total/8,
              per_live_source=total/340484,per_retained=total/71325,
              modeled_tile_hours=total/8*35871686/3600,modeled_live_grid_hours=total/340484*1775431871117/3600)
        out[lab]['sensitivities']=ratios
(p/'stock-timings.json').write_text(json.dumps(out,indent=2))
print({l:v.get('sensitivities',len(v['rows'])) for l,v in out.items()})
