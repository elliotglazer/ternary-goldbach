from collections import Counter
from pathlib import Path
import csv,json,hashlib
from flint import acb,arb,ctx
here=Path(__file__).resolve().parent
hol=here.parent
ctx.prec=180
S=1<<24;D=1<<57;B=1<<112;Q=10004
rnd=lambda z:int((z*S+arb(1)/2).floor().unique_fmpz())
rd=lambda z:(int(z)+D//2)//D
factors=[[],[]]
for h in range(1,9):
 s=acb(arb(1)/2,arb(5*h)/64)
 for a in (0,1):
  g=(s+a)/2; z=(acb(Q)/arb.pi())**g*g.gamma()*acb(Q)**(-s)
  factors[a].append(tuple(rnd(c) for c in (z.real,z.imag)))
slab=hol/"c10004-time-slab"
sp=[list(csv.DictReader((slab/f"h{h}-spectrum.tsv").open(),delimiter="\t")) for h in range(1,9)]
ph=[list(map(rd,row.split())) for row in (hol/"c10004-hol-shared-phase/phases.tsv").read_text().splitlines()]
ref=[list(csv.DictReader((hol/f"c10004-real-transform/h{h}-completed.tsv").open(),delimiter="\t")) for h in (1,2)]
shapes=json.loads((hol/"large-axis-fused-tree/terminal.json").read_text())["640"]["by_shape"]
pop=[(int(n),int(q),v) for key,v in shapes.items() for n,q in [key.split(",")] if int(n)<32]
lines=[]; receipts=[]
for j,(n,q,population) in enumerate(sorted(pop)):
 m=n-n//q; rows=[]; good=bad=fall=0
 for k in range(m):
  idx=(j*137+k*71)%2301; pp,qq=ph[idx]; a=(1+int(sp[0][idx]["k41"])+int(sp[0][idx]["k61"]))%2
  x=y=0; e=4096
  for lane in range(8):
   f,g=factors[a][lane]; r,i=map(rd,(sp[lane][idx]["re"],sp[lane][idx]["im"])); x+=r*B**lane;y+=i*B**lane
   A=pp*f-qq*g;C=pp*g+qq*f; val=A*r-C*i;err=(abs(A)+abs(C))*e+(abs(pp)+abs(qq)+abs(f)+abs(g)+2)*(abs(r)+abs(i)+2*e)
   ans=2 if val>err else 1 if val < -err else 0
   if min(map(abs,(pp,qq,f,g)))<=1: ch=0
   elif ((pp>0)==(f>0))!=((qq>0)==(g>0)): ch=1 if (pp>0)==(f>0) else 2
   else: ch=3 if (pp>0)!=(g>0) else 4
   z=r if ch<=2 else i
   if ch and abs(z)>e: assert ans==(2 if ((ch in (1,3))==(z>0)) else 1)
   else: fall+=1
   if lane<2 and ans: assert (ans==2)==(int(ref[lane][idx]["sign"])==1)
   good+=int(ans==2)<<(32*lane+k);bad+=int(ans==0)<<(32*lane+k)
  rows+=[(x,y,pp,qq,a,e)]
 lines+=[' '.join(map(str,(n,q,m,good,bad))),*[' '.join(map(str,r)) for r in rows]]
 receipts.append(dict(n=n,q=q,outputs=m*8,population=population,slow=fall,bad=bad.bit_count()))
(here/"rows.txt").write_text('\n'.join(lines)+'\n')
(here/"factors.txt").write_text('\n'.join(' '.join(str(z) for r in group for z in r) for group in factors)+'\n')
(here/"fixtures.json").write_text(json.dumps(receipts,indent=2))
