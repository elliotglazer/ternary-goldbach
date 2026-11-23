from pathlib import Path
import json,math
here=Path(__file__).resolve().parent
base=here.parent
allrows=set(); unique_radius=set(); rows={}
for q,p in [("10000",base/"full-height-count/stencils.txt"),("7689",here/"7689/kernels.txt"),("7283",here/"7283/kernels.txt")]:
    lines=p.read_text().splitlines()
    local={}
    for i in range(int(lines[0])):
        k,r,o,d,e=map(int,lines[1+2*i].split())
        w=tuple(map(int,lines[2+2*i].split()))
        key=(r,o,d,w)
        allrows.add(key);unique_radius.add((q,r,e));local[r,o]=key
    rows[q]=len(local)
out=dict(rows=rows,per_pilot_sum=sum(rows.values()),distinct_basis_vectors=len(allrows),distinct_radius_proofs=len(unique_radius))
(here/"pooled-basis.json").write_text(json.dumps(out,indent=2))
print(out)
