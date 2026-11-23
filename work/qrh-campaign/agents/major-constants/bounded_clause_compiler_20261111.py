"""Finite abstract-bitmask checks only. No prime data or arithmetic evaluator."""
from pathlib import Path
from hashlib import sha256
import json
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[3]
checks=0
def ck(test):
    global checks
    assert test
    checks+=1
def compile_rows(rows,cap):
    clauses=[];comparisons=0;copies=0;seen=0
    for t,h in enumerate(rows):
        seen+=1
        if h==0:return 'blocked',clauses,seen,comparisons,copies
        dominated=False
        for c,_ in clauses:
            comparisons+=1
            if c&h==c:dominated=True;break
        if dominated:continue
        kept=[]
        for c,tau in clauses:
            comparisons+=1
            if h&c!=h:kept.append((c,tau))
        clauses=kept+[(h,t)];copies+=len(clauses)
        if len(clauses)>cap:return 'cap',clauses,seen,comparisons,copies
        ck(all(any(c&r==c for c,_ in clauses) for r in rows[:seen]))
        ck(all(c==rows[tau] for c,tau in clauses))
        ck(all(c&d!=c for i,(c,_) in enumerate(clauses) for j,(d,_) in enumerate(clauses) if i!=j))
    return 'success',clauses,seen,comparisons,copies
cases={'success':0,'blocked':0,'cap':0}
L,D=4,2;M=D+1
for source in range(1<<(L+D)):
    rows=[sum(((source>>(t+s))&1)<<s for s in range(M)) for t in range(L)]
    for cap in range(5):
        status,clauses,seen,comparisons,copies=compile_rows(rows,cap)
        cases[status]+=1
        ck(seen<=L and comparisons<=2*L*cap and copies<=L*(cap+1))
        if status!='success':continue
        ck(1<=len(clauses)<=cap)
        union=0
        for c,tau in clauses:
            intersection=sum(all((rows[t]>>s)&1 for s in range(M) if (c>>s)&1)<<t for t in range(L))
            union|=intersection
            ck(c==rows[tau])
        ck(union==(1<<L)-1)
        for available in range(1<<M):
            ck(all(available&r for r in rows)==all(available&c for c,_ in clauses))
paths=['work/qrh-campaign/agents/major-constants/BINARY_SHARED_COVER_DICTIONARY_2026-11-11.md',
 'work/qrh-campaign/agents/zero-sum/REVIEW_BINARY_SHARED_COVER_DICTIONARY_2026-11-11.md',
 'work/qrh-campaign/agents/independent-feasibility/BINARY_SOURCE_BITMAP_COST_DESIGN_2026-11-11.md',
 'work/qrh-campaign/agents/moebius/EFFICIENCY_BINARY_COVERAGE_2026-11-11.md']
out={'scope':'abstract Boolean algorithm/invariants, not actual source data','checks':checks,'cases':cases,
 'parameters':{'tile_width':L,'palette_size':M,'offset_bound':D,'cap_values':list(range(5))},
 'pins':{p:sha256((ROOT/p).read_bytes()).hexdigest().upper() for p in paths}}
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(out,indent=2))
