from pathlib import Path
import sys,statistics,json,hashlib
from collections import defaultdict
here=Path(__file__).resolve().parent
native=json.loads((here/"native.json").read_bytes())
ledger=here.parent/"c10000-kronecker-time-price/tiles.json"
tile=next(r for r in json.loads(ledger.read_bytes()) if r["T"]==65536)
log=here/(sys.argv[1]+".log")
raw=defaultdict(lambda:defaultdict(list))
for line in log.read_text().splitlines():
    if not line.startswith("TILE "):continue
    _,size,n,answer,*times=line.split()
    raw[int(size)][int(n)].append([float(t.replace("~","-")) for t in times])
rows={}
totals=defaultdict(float)
for size,groups in sorted(raw.items()):
    counts=sorted(groups);assert len(counts)==3 and all(len(v)==2 for v in groups.values())
    lo,mid,hi=counts
    slopes=[]
    for i in range(2):
        slopes.append((groups[hi][i][1]-groups[lo][i][1])/(hi-lo))
    hol=statistics.mean(slopes)
    nn=native[str(size)]
    gn=statistics.median(z["cpu_each"] for z in nn["measurements"])
    gn_pure=statistics.median(z["single_cpu"] for z in nn["measurements"])
    row=dict(bytes=size,repetitions=counts,hol_cpu_each=hol,hol_cpu_replicates=slopes,
             hol_high_minus_mid_slopes=[(groups[hi][i][1]-groups[mid][i][1])/(hi-mid) for i in range(2)],
             hol_internal_setup_cpu=[v[1] for v in groups[0]],native_internal_setup_cpu=nn["setup_cpu"],
             native_checked_cpu_each=gn,native_single_pure_cpu=gn_pure,ratio=hol/gn,raw=groups)
    w=size*8//65536
    if str(w) in tile["control_groups"] and size==w*65536//8:
        count=tile["control_groups"][str(w)]
        old=tile["measured_full_products"][str(w)]["cpu_median"]
        row.update(width=w,count=count,original_native_cpu_each=old,direct_hours=count*hol/3600,
                   ratio_scaled_hours=count*old*hol/gn/3600)
        for key in ("direct_hours","ratio_scaled_hours"):totals[key]+=row[key]
        for i,slope in enumerate(slopes):
            totals["ratio_scaled_replicate_"+str(i)]+=count*old*slope/gn/3600
    rows[str(size)]=row
assert len(rows)==8 and sum(r.get("count",0) for r in rows.values())==1051852215
out=dict(rows=rows,totals=totals,native_original_hours=tile["hour_model"]["cpu_median"],hashes={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in [log,ledger,here/"native.json",here/"TilePriceScript.sml"]})
(here/"projection.json").write_text(json.dumps(out,indent=2)+"\n")
for size,r in rows.items():
    print(size,r["hol_cpu_each"],r["native_checked_cpu_each"],r["ratio"],r.get("ratio_scaled_hours"))
print(totals)
