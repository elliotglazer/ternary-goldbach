from pathlib import Path
import importlib.util, csv, math
from collections import Counter
d=Path(__file__).resolve().parent
b=d.parent
s=importlib.util.spec_from_file_location('ref',b/'c10004-real-transform/reference.py')
ref=importlib.util.module_from_spec(s);s.loader.exec_module(ref)
def rw(p):return [list(map(int,l.split())) for l in p.read_text().splitlines()]
def save(p,rows):p.write_text(''.join(' '.join(map(str,r))+'\n' for r in rows))
ph=rw(b/'c10004-hol-shared-phase/phases.tsv')
for h in [1,2]:
 raw=rw((b/'c10004-time-slab'/f'h{h}.tsv')) if False else [list(map(int,r.values())) for r in csv.DictReader((b/'c10004-time-slab'/f'h{h}.tsv').open(),delimiter='\t')]
 sub=[(a[2]-c[2],a[3]-c[3]) for a,c in zip(raw[::2],raw[1::2])]
 mid=[ref.ct(sub[i:i+40],True,Counter())[19] for i in range(0,2400,40)]
 spec=list(csv.DictReader((b/'c10004-real-transform'/f'h{h}-spectrum.tsv').open(),delimiter='\t'))[19*59:20*59]
 assert len(mid)==60 and int(spec[0]['k41'])==20
 for p in [24,28]:
  D=2**(81-p);S=2**p; rd=lambda x:(x+D//2)//D
  xs=[tuple(map(rd,z)) for z in mid]
  ws=[(round(S*math.cos(math.pi*(j*j%120)/60)),round(S*math.sin(math.pi*(j*j%120)/60))) for j in range(60)]
  def rot(a,w,s):
   x,y=a;u,v=w;return ((x*u-y*v+s//2)//s,(x*v+y*u+s//2)//s)
  aa=[rot(x,w,S) for x,w in zip(xs,ws)]
  ys=[]
  for k,w in enumerate(ws):
   R=I=0
   for j,(x,y) in enumerate(aa):
    u,v=ws[(k-j)%60];R+=x*u+y*v;I+=y*u-x*v
   ys.append(rot((R,I),w,S*S))
  cfg=rw(b/'c10004-hol-shared-phase'/f'h{h}-params.tsv')[0]
  rows=[];bits=0
  for k,((r,i),sr) in enumerate(zip(ys[1:],spec)):
   j=19*59+k; f,g=map(rd,cfg[2:4] if j%2==0 else cfg[0:2]); a,bb=map(rd,ph[j])
   e=(max(abs(r*D-int(sr['re'])),abs(i*D-int(sr['im'])))+int(sr['abs_error_grid_units'])+D-1)//D
   m=a*f-bb*g;n=a*g+bb*f; val=m*r-n*i
   assert abs(val)>(abs(m)+abs(n))*e+(abs(a)+abs(bb)+abs(f)+abs(g)+2)*(abs(r)+abs(i)+2*e)
   assert (val>0)==bool(cfg[-1]>>j&1)
   bits+=int(val>0)<<k;rows.append([a,bb,f,g,e])
  t=f'fu{p}h{h}'
  for suffix,arr in [('xs',xs),('ws',ws),('phase',rows),('taps',[ys[i] for i in [0,1,30,59]]),('cfg',[[S,sum(r+3*i for r,i in ys)%65537,bits]])]:save(d/(t+suffix+'.txt'),arr)
orig=(d/'LargeTerminalPriceScript.sml').read_text().split('fun measure p =')[0].replace('Theory LargeTerminalPrice','Theory FusedPrice').replace('Ancestors LargeTerminal JoinTables','Ancestors Fused JoinTables')
worker="""fun localrun t =
 let fun rs name=replay.lines(map integer)(t^name^".txt")
     fun il name=let val vs=map replay.tuple(rs name) in replay.literal(replay.named(t^name)(listSyntax.mk_list(vs,type_of(hd vs)))) end
     val [sc,chk,mask]=hd(replay.lines(fn x=>x)(t^"cfg.txt"))
     val xs=il "xs" and ws=il "ws" and cs=il "phase" and taps=il "taps"
     fun trial (n,m)= let val _=print("FUSED "^t^" "^Int.toString n^" "^Bool.toString m^"\\n")
     val res=joined ``Fused$compare_run`` [enc(nat(Int.toString n)),enc(if m then T else F),enc(integer sc),xs,ws,cs,enc(integer chk),taps,enc(nat mask)]
     in if n=1 then ignore(save_thm(t^Bool.toString m,res)) else () end
 in List.app trial [(1,false),(1,true),(64,true),(64,false),(256,false),(256,true),(256,true),(256,false),(256,false),(256,true)] end;
val _=List.app localrun ["fu24h1","fu24h2","fu28h1","fu28h2"];
"""
(d/'FusedPriceScript.sml').write_bytes((orig+worker).encode())
hm=(d/'Holmakefile').read_text().strip()
if '../large-axis-sample/fast' not in hm:(d/'Holmakefile').write_bytes((hm+' ../large-axis-sample/fast\n').encode())
run=(d/'run.sh').read_text().replace('Sector|SectorPrice)','Sector|SectorPrice|Fused|FusedPrice)')
(d/'run.sh').write_bytes(run.encode())
