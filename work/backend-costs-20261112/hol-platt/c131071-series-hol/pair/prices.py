from pathlib import Path
from statistics import median
import json,sys
p=Path(__file__).resolve().parent
log=p/(sys.argv[1]+".log")
lines=log.read_text().splitlines()
cases=json.loads((p.parent/"cases.json").read_text())
results={}
for c in cases:
    n=c["n"]
    for what in ["warm","shared","cold","direct"]:
        name=c['name']+'_'+what
        vals=[[float(x) for x in l.split()[3:]] for l in lines if l.startswith("SERIES "+name+" ")]
        assert len(vals)==5
        adm=float(next(l.split()[2] for l in lines if l.startswith("ADMIT "+name+" ")))
        results[name]=dict(kernel_us=median(x[0] for x in vals)*1e6/n,warm_us=median(map(sum,vals))*1e6/n,admission_s=adm)
print(json.dumps(results,indent=2))

