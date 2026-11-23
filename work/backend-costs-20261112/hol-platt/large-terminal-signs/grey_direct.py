from pathlib import Path
from flint import arb,acb,ctx
import csv,json,time
d=Path(__file__).resolve().parent;b=d.parent/'large-sector-second';ctx.prec=120;n=131070;S=2**28;W=2**56
def read(name):return [tuple(map(int,r)) for r in list(csv.reader((b/name).open(),delimiter='\t'))[1:]]
raw=[r[2:] for r in read('input28.tsv')];roots=read('roots28.tsv'); parts=json.loads((b/'cohort.json').read_text())['phase_parts_grid28']
sites={x['k']:x for p in [24,28] for x in json.loads((d/f'grey{p}.json').read_text())}
keys=sorted(k for k,v in sites.items() if v['lost'] or v['delay'])
tw=[]
for j in range(n):
 w=acb(0,2*arb.pi()*j/n).exp()
 u=int((w.real*W+arb(1)/2).floor().unique_fmpz());v=int((w.imag*W+arb(1)/2).floor().unique_fmpz())
 assert abs(w.real*W-u)<1 and abs(w.imag*W-v)<1
 tw.append((u,v))
mass=sum(abs(x)+abs(y) for x,y in raw)
# max(|wr|+|wi|) is rigorously computable from whole integer table.
rad=(n*(max(abs(u)+abs(v) for u,v in tw)+2)+mass+W-1)//W+1
out=[]
for k in keys:
 t=time.process_time();A=B=0;j=0
 for x,y in raw:
  u,v=tw[j];A+=u*x-v*y;B+=v*x+u*y;j=(j+k)%n
 a=(A+W//2)//W;bb=(B+W//2)//W;_,p,q=roots[k-1];f,g=parts[k%2]
 u=p*f-q*g;v=p*g+q*f;sc=u*a-v*bb;er=(abs(u)+abs(v))*rad+(abs(p)+abs(q)+abs(f)+abs(g)+2)*(abs(a)+abs(bb)+2*rad)
 ans=1 if sc>er else -1 if sc< -er else 0
 assert ans==0 or (ans>0)==(sites[k]['center']=='1')
 out.append(dict(k=k,strict=ans,rad_p28=rad,lost=sites[k]['lost'],delay=sites[k]['delay'],cpu=time.process_time()-t))
print('direct finite recovery',len(out),sum(v['strict']!=0 for v in out),[v for v in out if v['lost'] or not v['strict']])
(d/'grey-direct.json').write_text(json.dumps(out,indent=2))
