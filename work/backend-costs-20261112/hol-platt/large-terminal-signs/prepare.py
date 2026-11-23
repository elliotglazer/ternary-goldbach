from pathlib import Path
import json,csv,hashlib
from math import ceil
out=Path(__file__).resolve().parent
base=out.parent
ph=base/"c10004-hol-shared-phase"
native=base/"c10004-real-transform"
phases=[list(map(int,l.split())) for l in (ph/"phases.tsv").read_text().splitlines()]
read=lambda h:list(csv.DictReader((native/f"h{h}-spectrum.tsv").open(),delimiter="\t"))
ys=[read(1),read(2)]
params=[list(map(int,(ph/f"h{h}-params.tsv").read_text().split())) for h in (1,2)]
meta={}
for bits in (24,28,81):
    drop=2**(81-bits)
    rd=lambda x:(x+drop//2)//drop
    co=[]
    for f,g,F,G,e,m in params:
        co.append([rd(F),rd(G),rd(f),rd(g),e if bits==81 else (e+drop-1)//drop+1])
    output=[]; full=[]
    for j,phase in enumerate(phases):
        p,q=map(rd,phase)
        row=[p,q]
        ss=[]
        for h in range(2):
            r,i=[rd(int(ys[h][j][k])) for k in ("re","im")]
            row+=[r,i]
            f,g=co[h][0:2] if j%2==0 else co[h][2:4]
            e=co[h][4]; a,b=p*f-q*g,p*g+q*f
            v=a*r-b*i
            E=(abs(a)+abs(b))*e+(abs(p)+abs(q)+abs(f)+abs(g)+2)*(abs(r)+abs(i)+2*e)
            sign=1 if v>E else (-1 if v < -E else 0)
            assert sign==(1 if (params[h][-1]>>j)&1 else -1)
            ss.append(sign>0)
        output.append(row);full.append(ss)
    blocks=[]
    for start in range(0,len(full),64):
        masks=[sum(int(x[t])<<i for i,x in enumerate(full[start:start+64])) for t in (0,1)]
        blocks.append([*masks,(masks[0]^masks[1]).bit_count()])
    assert sum(x[2] for x in blocks)==153
    (out/f"data{bits}.txt").write_text("".join(" ".join(map(str,row))+"\n" for row in output))
    (out/f"cfg{bits}.txt").write_text(" ".join(map(str,co[0]+co[1]))+"\n")
    (out/f"masks{bits}.txt").write_text("".join(" ".join(map(str,row))+"\n" for row in blocks))
    meta[bits]=dict(samples=4602,blocks=len(blocks),opposites=153,radii=[c[-1] for c in co])
(out/"fixture.json").write_text(json.dumps(meta,indent=2))
