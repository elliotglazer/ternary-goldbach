import json
from pathlib import Path
from itertools import groupby
here=Path(__file__).resolve().parent
out={}
for label in (3,6667,11,9091):
    rows=[tuple(map(int,s.split())) for s in (here.parent/"full-height-count"/f"signs-{label}.tsv").read_text().splitlines()]
    assert rows==sorted(rows)
    result=[]
    for a,b in [(0,1),(0,2),(0,3),(0,4),(1,2),(2,3),(3,4)]:
        selected=[s for t,s in rows if a*84224*4096//4<t<b*84224*4096//4]
        n=sum(1 for _ in groupby(selected))
        result.append([a,b,n,len(selected),n/len(selected)])
    out[label]=result
(here/"cutoffs.json").write_text(json.dumps(out,indent=2))
print(out)
