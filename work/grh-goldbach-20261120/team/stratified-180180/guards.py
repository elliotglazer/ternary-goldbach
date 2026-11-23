"""Exhaust every positive aligned guard through 50 against the eight frozen pairs."""
from bisect import bisect_right
from fractions import Fraction as F
from hashlib import sha256
import json
from pathlib import Path
import sys
from flint import arb,ctx

out=Path(__file__).resolve().parent
parent=out.parents[2]/'backend-costs-20261112/hol-platt'
sys.path.append(str(parent/'one-character-completeness'))
from phase_ends import enclosure,SCALE
ctx.prec=160
freeze=json.loads((out/'freeze.json').read_bytes())
q=freeze['q']
T=F(freeze['row'][3])
sub=20480
base=int(T*64*sub/5)
drop={1,base-1,base+1,base+320*sub-1,base+640*sub-1}
panels=[]
for i in range(4):
    p=out/f'group{i}'
    counts=json.loads((p/'counts.json').read_bytes())
    aligned=json.loads((p/'inclusive-rounded.json').read_bytes())
    for parity in (0,1):
        _,a,b=freeze['selected'][parity][i]
        K=0
        tips=[]
        for label in [a,b]:
            f=p/f'signs-{label}.tsv'
            assert sha256(f.read_bytes()).hexdigest()==counts['sha256'][f.name]
            seq=[tuple(map(int,x.split())) for x in f.read_text().splitlines()]
            seq=[(k,s) for k,s in seq if k not in drop]
            def flips(nodes): return [j for (_,s),(j,t) in zip(nodes,nodes[1:]) if s!=t]
            K+=len(flips([(k,s) for k,s in seq if k<=base]))
            tips.extend(flips([(k,s) for k,s in seq if k>=base]))
        tips.sort()
        summed=[0]
        for j in tips: summed.append(summed[-1]+j)
        panels.append(dict(labels=[a,b],K=K,parity=parity,tips=tips,summed=summed,reference=
            {r['guard']:r for r in aligned['rows'] if r['labels']==[a,b]}))
records=[]
for g in range(1,641):
    H=T+F(5*g,64)
    tick=base+g*sub
    phi=[F(enclosure(q,k,T,H)[1],SCALE) for k in (0,1)]
    logq=(arb(q*H.numerator)/(H.denominator*2*arb.pi())).log()
    rum=F(int((((18397+1242*logq)/10000)*2**32).upper().ceil().unique_fmpz()),2**32)
    for pair in panels:
        n=bisect_right(pair['tips'],tick)
        w=n*tick-pair['summed'][n]
        W=F(5*w,64*sub)
        excess={policy:(phi[pair['parity']]-W+2*allow)/(H-T)-pair['K'] for policy,allow in [('moderate',18),('Rumely',rum)]}
        if g in (320,640):
            ref=pair['reference'][g]
            assert w==ref['W_ticks'] and {k:str(v) for k,v in excess.items()}==ref['U_minus_K']
        records.append(dict(guard_ticks=g,labels=pair['labels'],K=pair['K'],W_ticks=w,phase_upper=str(phi[pair['parity']]),
                            Rumely_allowance=str(rum),excess={k:str(v) for k,v in excess.items()}))
def successes(pol,g):
    return sum(F(r['excess'][pol])<1 for r in records if r['guard_ticks']==g)
summary={}
for policy in ('moderate','Rumely'):
    first=[]; last_failure=[]
    for pair in panels:
        data=[(r['guard_ticks'],F(r['excess'][policy])) for r in records if r['labels']==pair['labels']]
        first.append(next((g for g,x in data if x<1),None))
        last_failure.append(max([g for g,x in data if x>=1],default=0))
    all_pass=next(g for g in range(1,641) if successes(policy,g)==8)
    policies={}
    for g in [160,256,320,448,480,512,544,576,608,640]:
        data=[float(F(r['excess'][policy])) for r in records if r['guard_ticks']==g]
        policies[g]=dict(passed=sum(x<1 for x in data),min=min(data),max=max(data))
    summary[policy]=dict(first_ticks=first,last_failed_ticks=last_failure,first_common_ticks=all_pass,fixed=policies)
(out/'guard-widths.json').write_text(json.dumps(dict(labels=[p['labels'] for p in panels],summary=summary,records=records),separators=(',',':')))
print(summary)
