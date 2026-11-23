from pathlib import Path
import json
d=Path(__file__).resolve().parent
base=(d/"LargeTerminalScript.sml").read_text()
start=base.index("Definition packet_def:")
body=base[start:base.index("Definition skim_def:")]
body=body.replace("packet","sector_packet").replace("verified","sector_verified").replace("checked","sector_checked")
body=body.replace("0:num,0:num,0:num","0:num,0:num,0:num,0:num,0:num").replace("let l=score (p,q) f (r,i); h=score (p,q) a (s,j) in","let x=one (p,q) f (r,i); y=one (p,q) a (s,j); l=if x=0 then LargeTerminal$score (p,q) f (r,i) else x; h=if y=0 then LargeTerminal$score (p,q) a (s,j) else y in").replace("SOME(m,n,c)","SOME(m,n,c,u,v)").replace("c+(if l=h then 0 else 1)","c+(if l=h then 0 else 1),2*u+(if x=0 then 1 else 0),2*v+(if y=0 then 1 else 0)")
times=base[base.index("Definition times_def:"):].replace("times","sector_times").replace("trial","sector_trial").replace("checked rows","sector_checked rows").replace("sink rows","LargeTerminal$sink rows")
gate="""Theory Sector
Ancestors LargeTerminal
Libs cv_transLib intLib
Definition one_def:
 one (p:int,q:int) (f:int,g:int,e:int) (r:int,i:int) =
  if ABS p<=1 \/ ABS q<=1 \/ ABS f<=1 \/ ABS g<=1 then (0:num) else
  let pf=(0<p <=> 0<f); qg=(0<q <=> 0<g);
      use_re=(pf<>qg); c=if use_re then r else i;
      orient=if use_re then pf else (0<p <> (0<g))
  in if ABS c<=e then 0 else if orient=(0<c) then 2 else 1
End
""".replace("(0<p <> (0<g))","((0<p) <> (0<g))")
(d/"SectorScript.sml").write_bytes((gate+body+times).encode())
w=(d/"LargeTerminalPriceScript.sml").read_text().replace("Theory LargeTerminalPrice","Theory SectorPrice").replace("Ancestors LargeTerminal JoinTables","Ancestors Sector JoinTables").replace("LargeTerminal$trial","Sector$sector_trial").replace('"masks"^p','"sector"^p')
w=w.replace('[(0,false),(1,false),(1,true),(4,true),(4,false),(8,false),(8,true),(8,true),(8,false)]','[(1,false),(1,true),(32,true),(32,false),(32,false),(32,true),(32,true),(32,false)]')
(d/"SectorPriceScript.sml").write_bytes(w.encode())
report={}
for p in [24,28,81]:
 rows=[list(map(int,l.split())) for l in (d/f"data{p}.txt").read_text().splitlines()]
 masks=[list(map(int,l.split())) for l in (d/f"masks{p}.txt").read_text().splitlines()]
 cfg=list(map(int,(d/f"cfg{p}.txt").read_text().split()))
 stats=[0,0]
 for block,expected in enumerate(masks):
    miss=[0,0]
    for ix,row in enumerate(rows[64*block:64*(block+1)]):
        x,y,*z=row
        for h in [0,1]:
            i,j=z[2*h:2*h+2]; f,g=cfg[5*h+(2 if ix%2 else 0):][:2]
            e=cfg[5*h+4]
            pf=(x>0)==(f>0); qg=(y>0)==(g>0)
            if pf!=qg: c,orient=i,pf
            else: c,orient=j,(x>0)!=(g>0)
            if min(abs(x),abs(y),abs(f),abs(g))<=1 or abs(c)<=e: miss[h]+=1<<ix;stats[h]+=1
            else: assert (orient==(c>0))==bool(expected[h]>>ix&1)
    expected.extend(miss)
 (d/f"sector{p}.txt").write_text("".join(" ".join(map(str,m))+"\n" for m in masks))
 report[p]=stats
(d/"sector-native.json").write_text(json.dumps(report))
sh=(d/"run.sh").read_text().replace("LargeTerminal|LargeTerminalPrice)","LargeTerminal|LargeTerminalPrice|Sector|SectorPrice)")
(d/"run.sh").write_bytes(sh.encode())
print(report)
