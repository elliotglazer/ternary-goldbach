"""Independently reproduce C grid counts with NumPy and summarize timing costs."""
import json
import statistics
import numpy as np
from collections import Counter
from actual_cover import ROOT,FULL

data=np.fromfile(ROOT/"native_masks.bin",dtype="<u8")
n,cols=map(int,data[:2]); rows=data[2:].reshape(n,cols)
rows=rows[[i for i in range(n) if (i//128)%5 != 0]]
runs=[json.loads((ROOT/f"pool_grid_run_{i}.json").read_text(encoding="utf-8-sig")) for i in (1,2,3)]
out=[]
for case,small in enumerate((64,128,256,512)):
    counts=[]; fallbacks=0
    for row in rows:
        rem=np.uint64(FULL);active=small;count=0
        while rem:
            scores=np.bitwise_count(row[:active]&rem)
            k=int(np.argmax(scores))
            if not scores[k]:
                assert active<512
                active=512;fallbacks+=1;continue
            rem &= ~row[k];count+=1
        counts.append(count)
    c=runs[0]["cases"][case]
    assert dict(Counter(counts))=={int(k):v for k,v in c["histogram"].items()}
    assert fallbacks==c["fallback_words"]
for i,c in enumerate(runs[0]["cases"]):
    wall=[1e6*r["cases"][i]["wall_seconds"]/(r["rows"]*r["cases"][i]["repetitions"]) for r in runs]
    out.append(dict(initial_pool=c["initial_pool"],method=c["method"],mean_selected=c["mean_selected"],
                    fallback_fraction=c["fallback_words"]/runs[0]["rows"],
                    median_wall_us=statistics.median(wall),wall_us_range=[min(wall),max(wall)]))
costs=[]
for lam in (0,.1,.5,1,2,5):
    values=[dict(pool=r["initial_pool"],total_us=r["median_wall_us"]+lam*r["mean_selected"]) for r in out]
    costs.append(dict(additional_us_per_mask=lam,best_pool=min(values,key=lambda r:r["total_us"])["pool"],values=values))
result=dict(independent_numpy_counts_match=True,rows=len(rows),cases=out,cost_scenarios=costs,
            warning="Additional per-mask costs are scenarios; timings are measured native C construction plus search")
(ROOT/"pool_grid_summary.json").write_text(json.dumps(result,indent=2))
print(json.dumps(result,indent=2))
