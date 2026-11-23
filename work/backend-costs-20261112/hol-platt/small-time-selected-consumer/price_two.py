from pathlib import Path
import csv,re,json,statistics
p=Path(__file__).resolve().parent
nat=list(csv.DictReader((p/'two-integrated.csv').open()));out={}
def report(tag,v):
    base=[x[1] for x in v];payload=[x[2] for x in v]
    out[tag]=dict(values=payload,median=statistics.median(payload),matched_net=[y-x for x,y in zip(base,payload)],median_net=statistics.median(y-x for x,y in zip(base,payload)))
vals=[]
for i in range(5):
    vals.append([sum(float(r['wall']) for r in nat if int(r['rep'])==i and r['mode']==m) for m in ('baseline2','baseline3','heads2')])
report('native_net_over_original_three_carries',vals)
for f in p.glob('two*_bench.log'):
    ds={}
    for l,d,m,c,w in re.findall(r'^(\d+),(\d+),(\d+),([.\d]+),([.\d]+)',f.read_text(),re.M):ds.setdefault((l,d),{})[int(m)]=float(c)
    done=[v for v in ds.values() if len(v)==4]
    if not done:continue
    r={}
    for m in [2,3,4]:
        deltas=[v[m]-v[1] for v in done];r[m]=dict(mean=statistics.mean(deltas),total=sum(deltas),deltas=deltas)
        if len(done)==8:r[m].update(tile_hours=statistics.mean(deltas)*35871686/3600,live_hours=sum(deltas)*1775431871117/340484/3600)
    out[f.stem]=dict(completed=len(done),matched_net=r)
(p/'two-price.json').write_text(json.dumps(out,indent=2));print(out)
