from pathlib import Path
from math import gcd
from collections import defaultdict
import sys,json,hashlib
root=Path(__file__).resolve().parent
artifact=Path(sys.argv[1])
data=json.loads(artifact.read_bytes())
receipt=root.parents[2]/"qrh-campaign/agents/integration/guarded_residue_evaluation_frontier_20261111.json"
rec=json.loads(receipt.read_bytes())["selected_records"]["band1_K20_b94"]
stages=rec["stages"]
units=defaultdict(list)
for a in range(1,10004):
    if gcd(a,10004)==1:
        units[(2048*a+10003)//20008].append(a)
def integer(x):return str(x).replace("-","~")
def tup(xs):return "("+",".join(integer(int(t)) for t in xs)+")"
def hol_list(xs):return "["+";".join(xs)+"]"
provider_file=artifact.with_name("h1-horner.json")
provider=None
if artifact.name=="h1-mixed.json":
    assert hashlib.sha256(provider_file.read_bytes()).hexdigest()=="35f43fd7d2ded71fe52c93743747700acad89c360d3e21571321013db01f40ef"
    provider={a:(k,x,y) for _,a,k,x,y in json.loads(provider_file.read_bytes())}
    assert len(provider)==4800
keys=list(units)
with (root/"actual_terms.txt").open("w",encoding="ascii",newline="\n") as out:
    for start in range(0,len(keys),16):
        groups=[];expected=[]
        for k in keys[start:start+16]:
            coeff=[[int(x),int(y)] for x,y in data[str(k)]]
            assert len(coeff)==20
            terms=[]
            for s in stages:
                lo,hi=s["grids"]
                terms.append(tup([1<<(hi-lo),*coeff[s["j"]]]))
            groups.append(f"({k},{tup(coeff[-1])},{hol_list(terms)},{hol_list(map(str,units[k]))})")
            for a in units[k]:
                r=1024*a-10004*k
                m=coeff[-1]
                for s in stages:
                    assert all(abs(v).bit_length()<=s["Mbits"] for v in m)
                    lo,hi=s["grids"]
                    row=[]
                    for v,n in zip(m,coeff[s["j"]]):
                        x=(r*v)<<(hi-lo)
                        q,rem=divmod(x,20008)
                        q+=rem>=10004
                        assert -20008<=2*(x-q*20008)<20008
                        row.append(q+n)
                    m=row
                if provider is not None:
                    assert (k,*m)==provider[a]
                expected.append(tup([64*v for v in m]))
        out.write("actual_groups "+hol_list(groups)+"\n"+hol_list(expected)+" : (int # int) list\n")
print(len(keys),sum(map(len,units.values())),hashlib.sha256(artifact.read_bytes()).hexdigest())

