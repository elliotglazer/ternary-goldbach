from pathlib import Path
import csv,json,statistics,re
p=Path(__file__).resolve().parent
rr=list(csv.DictReader((p/'native-integrated.csv').open()));nat={}
for m in ('baseline','ordinary','fused'):
    nat[m]=[sum(float(r['wall']) for r in rr if r['mode']==m and int(r['rep'])==i) for i in range(5)]
nat['incremental_fused']=[a-b for a,b in zip(nat['fused'],nat['baseline'])]
nat['incremental_ordinary']=[a-b for a,b in zip(nat['ordinary'],nat['baseline'])]
nat['fusion_credit']=[a-b for a,b in zip(nat['ordinary'],nat['fused'])]
out={'native':nat}
for f in p.glob('int*_bench.log'):
    ts={}
    for l,d,m,c,w in re.findall(r'^(\d+),(\d+),(\d+),([.\d]+),([.\d]+)',f.read_text(),re.M):ts.setdefault((l,d),{})[int(m)]=float(c)
    finished={k:v for k,v in ts.items() if len(v)==3}
    if not finished:continue
    vals={}
    for tag,j,k in [('ordinary_after_paid_split',2,1),('fused_after_paid_split',3,1),('fusion_credit',2,3)]:
        dif=[v[j]-v[k] for v in finished.values()]
        vals[tag]=dict(values=dif,total=sum(dif),mean_per_tile=statistics.mean(dif))
        if len(finished)==8:vals[tag].update(tile_count_hours=statistics.mean(dif)*35871686/3600,live_count_hours=sum(dif)*1775431871117/(340484*3600))
    out[f.stem]=dict(completed=len(finished),costs=vals)
(p/'integrated-summary.json').write_text(json.dumps(out,indent=2));print({k:round(statistics.median(v),4) for k,v in nat.items()});print({k:v for k,v in out.items() if k!='native'})
