"""Independent abstract-set and integer-layout checks; no prime data."""
from pathlib import Path
from itertools import combinations
import json,hashlib
HERE=Path(__file__).resolve().parent;A=HERE.parent;ROOT=A.parents[2]
author=A/'major-constants'
pins={'BINARY_SHARED_COVER_DICTIONARY_2026-11-11.md':'3B9747B5502C2AD7665A17EA55D2DF1357AA97D8CB874239C350DA21DD4F5E0A',
'binary_cover_dictionary_metadata_20261111.py':'9E97CDAF5C8C5837FF08B25A37AA54D34D8B991526A707FF5E034251F3882976',
'binary_cover_dictionary_metadata_20261111.json':'C81B37DA6AFA850FA07A5449BBF3D734A564B3CE01E2A426D2AD146601ED46DE'}
n=0
def ck(v):
 global n
 assert v
 n+=1
for p,h in pins.items():ck(hashlib.sha256((author/p).read_bytes()).hexdigest().upper()==h)
data=json.loads((author/'binary_cover_dictionary_metadata_20261111.json').read_text())
for p,h in data['input_sha256'].items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
for L,D in [(3,1),(5,2)]:
 for mask in range(1<<(L+D)):
  rows={frozenset(s for s in range(D+1) if mask&(1<<(t+s))) for t in range(L)}
  minima={h for h in rows if not any(g<h for g in rows)}
  for k in range(D+2):
   for tup in combinations(range(D+1),k):
    active=set(tup)
    ck(all(active&h for h in rows)==all(active&h for h in minima))
  ck(all(any(g<=h for g in minima) for h in rows))
# Exact coverage and disjointness, including final width one and small boundary cases.
for E in range(2,41):
 for L in range(2,E+1):
  R=E//L;initial=list(range(2,L));outer=[]
  for r in range(1,R+1):
   w=min(L,E-r*L+1)
   ck(1<=w<=L)
   outer.extend(r*L+t for t in range(w))
  ck(initial+outer==list(range(2,E+1)))
  if E%L==0:ck(len(outer)>0 and min(L,E-R*L+1)==1)
for row in data['layout']:
 E=row['B']//2;L=row['L'];W=2**18;R=E//L;last=E%L+1
 ck(R==row['outer_blocks'] and last==row['last_width'])
 ck((R-1)*(L//W)+(last+W-1)//W==row['actual_outer_tiles'])
out=dict(scope='Independent abstract coverage and integer boundaries only; no prime evaluations',checks=n,author_pins=pins,source_pins=data['input_sha256'])
with (HERE/'review_binary_shared_cover_20261111.json').open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':n,'status':'PASS'}))
