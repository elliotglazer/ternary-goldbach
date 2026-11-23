import json,sys,statistics,hashlib
from collections import defaultdict
from pathlib import Path
d=Path(__file__).resolve().parent
log=d/f"{sys.argv[1]}.log"
groups=defaultdict(list)
for line in log.read_text().splitlines():
    if not line.startswith("LEAF "):continue
    _,leaf,n,start,*times=line.split()
    groups[int(n)].append((int(leaf),int(start),*[float(t.replace("~","-")) for t in times]))
summary={}
for n in (1,4,8):
    rows=groups[n]
    assert set((r[0],r[1]) for r in rows)=={(a,b) for a in range(8) for b in range(0,8,n)}
    sums=[sum(row[i] for row in rows) for i in range(2,7)]
    summary[n]={"groups":len(rows),"scalar_equivalent_five_point_transforms":64,"cpu_s":dict(zip(("term_construction","prepare","kernel","decode","exact_comparison"),sums)),"kernel_us_per_scalar_leaf":sums[2]*1e6/64,"median_group_kernel_us":statistics.median(r[4] for r in rows)*1e6,"kernel_s_by_leaf":[sum(r[4] for r in rows if r[0]==a) for a in range(8)]}
for n in summary:
    summary[n]["speedup_as_measured_kernel"]=summary[1]["cpu_s"]["kernel"]/summary[n]["cpu_s"]["kernel"]
result={"modes":summary,"inputs_sha256":hashlib.sha256((d/"terms.txt").read_bytes()).hexdigest(),"sml_sha256":hashlib.sha256((d/"LeafPriceScript.sml").read_bytes()).hexdigest(),"log_sha256":hashlib.sha256(log.read_bytes()).hexdigest()}
(d/"result.json").write_text(json.dumps(result,indent=2)+"\n")
print(json.dumps(result,indent=2))
