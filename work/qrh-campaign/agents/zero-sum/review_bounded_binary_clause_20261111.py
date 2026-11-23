"""Independent set-based capped-clause audit on abstract rows, without prime data."""
from pathlib import Path
from itertools import product
import hashlib,json
HERE=Path(__file__).resolve().parent;A=HERE.parent;ROOT=A.parents[2]
AUTHOR=A/'major-constants'
pins={'BOUNDED_BINARY_CLAUSE_PROOF_REPRESENTATION_2026-11-11.md':'A43E9F4B180D0406BE0BC147DD793BD4DEE8F83F44BF86E57BA1479BB19279E3',
'bounded_clause_compiler_20261111.py':'04996317A13CC000EC173870F51A666C67B2D95CAC6C012E934B531C7F8C60C5',
'bounded_clause_compiler_20261111.json':'4B6B7C4BB7572F0F636E812F12E2A5ABC4875F1D3AB4C7CD2F354FDF63FC17E6'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for p,h in pins.items():ck(hashlib.sha256((AUTHOR/p).read_bytes()).hexdigest().upper()==h)
receipt=json.loads((AUTHOR/'bounded_clause_compiler_20261111.json').read_text())
for p,h in receipt['pins'].items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
def compile_sets(rows,cap):
 kept=[];comp=0;copied=0
 for t,h in enumerate(rows):
  if not h:return 'blocked',kept,comp,copied
  found=False
  for c,witness in kept:
   comp+=1
   if c<=h:found=True;break
  if not found:
   survivors=[]
   for c,witness in kept:
    comp+=1
    if not h<=c:survivors.append((c,witness))
   kept=survivors+[(h,t)];copied+=len(kept)
   if len(kept)>cap:return 'cap',kept,comp,copied
  ck(all(c==rows[tau] for c,tau in kept))
  ck(all(any(c<=r for c,_ in kept) for r in rows[:t+1]))
  ck(all(not c<=d for i,(c,_) in enumerate(kept) for j,(d,_) in enumerate(kept) if i!=j))
 return 'success',kept,comp,copied
sets=[frozenset(i for i in range(3) if n&(1<<i)) for n in range(8)]
statuses={'blocked':0,'cap':0,'success':0}
for rows in product(sets,repeat=3):
 for cap in range(4):
  status,cs,comp,copied=compile_sets(rows,cap);statuses[status]+=1
  ck(comp<=2*len(rows)*cap and copied<=len(rows)*(cap+1))
  if status=='success':
   ck(1<=len(cs)<=cap)
   ck({c for c,_ in cs}=={r for r in rows if not any(q<r for q in rows)})
   for active in sets:ck(all(active&r for r in rows)==all(active&c for c,_ in cs))
  if status=='blocked':ck(any(not r for r in rows))
# Overflow is not a lower bound on the completed minimal family.
late=[frozenset([0,1]),frozenset([0,2]),frozenset([0,3]),frozenset([0])]
ck(compile_sets(late,2)[0]=='cap')
unlimited=compile_sets(late,4);ck(unlimited[0]=='success' and len(unlimited[1])==1)
# Sufficient proper subclauses and full-tile restriction can strengthen acceptance.
ck(bool({1}&{0,1}) and not bool({1}&{0}))
ck(bool({0}&{0}) and not all({0}&r for r in [{0},{1}]))
out=dict(scope='Abstract set invariants and exact work bounds, no prime data',checks=checks,statuses=statuses,author_pins=pins,dependency_pins=receipt['pins'])
with (HERE/'review_bounded_binary_clause_20261111.json').open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'statuses':statuses,'status':'PASS'}))
