"""Independently extract all archived input integers from the exported theory's source."""
from hashlib import sha256
from pathlib import Path
import json
import re

here=Path(__file__).resolve().parent
p=here.parent/"guard-repricing"
source=(here/"StripParameterAcceptanceScript.sml").read_text()
raw=(p/"strip-repair-packets-stress.tsv").read_bytes()
assert sha256(raw).hexdigest()=="1944893a89f38dd3cb1e69a06f284f909b030d6671a77cf333266d26b1987a29"
results=[]
for m in re.finditer(r"Definition sp(\d+)_def:\n.*? = (.*?)\nEnd",source):
    assert int(m[1])==len(results)
    results.append(list(map(int,re.findall(r"-?\d+",m[2]))))
assert results==[list(map(int,s.split())) for s in raw.splitlines()]
log=(here/"param02.log").read_text()
assert (here/"param02.status").read_text().strip()=="0"
for prefix,suffix,count in [("sg","ok",40),("sm","ok",14),("sp","accepted",270)]:
    assert len(set(re.findall(r'Saved theorem _+ "('+prefix+r'\d+_'+suffix+')"',log)))==count
assert 'Exporting theory "StripParameterAcceptance" ... done.' in log
sig=(here/".hol/objs/StripParameterAcceptanceTheory.sig").read_text()
assert all(re.search(r"\bsp"+str(n)+r"_accepted\b",sig) for n in range(270))
times=dict((key,float(value)) for key,value in re.findall(r"PARAMETER_TIME (\w+) ([0-9.]+)",log))
print(json.dumps(dict(literal_packet_rows=len(results),verified_integers=sum(map(len,results)),
    geometry_cpu=times["geometries"]-times["start"],mass_cpu=times["mass"]-times["geometries"],
    row_cpu=times["packets"]-times["mass"],row_cpu_per_packet=(times["packets"]-times["mass"])/len(results)),indent=2))
