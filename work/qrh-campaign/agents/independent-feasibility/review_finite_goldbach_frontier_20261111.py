"""Independent finite geometry and rational-cost checks. Labels are not asserted prime."""
from pathlib import Path
from fractions import Fraction as F
from itertools import combinations
import hashlib
import json
import re

BASE=Path(__file__).resolve().parent.parent
WORK=BASE.parent.parent
AUTHOR=BASE/'prime-estimates/FINITE_GOLDBACH_GLOBAL_COST_FRONTIER_2026-11-11.md'
checks=0
def need(p):
 global checks
 assert p
 checks+=1
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest().upper()
need(sha(AUTHOR)=='F950F36C3361A4BABB253B502168B613893DB5DCD002599A7BC261A950A16FC6')
pins={}
for name,digest in re.findall(r'^\| (.+?) \| ([0-9A-F]{64}) \|$',AUTHOR.read_text(),re.M):
 path=WORK/name if ', under qrh-campaign' not in name else WORK/'qrh-campaign'/name.split(',')[0]
 need(sha(path)==digest); pins[str(path.relative_to(WORK))]=digest
need(len(pins)==12)
for name,digest in [('finite_cover_frontier_20261111.py','442F8F28378576DF95CD051ED130ACFCA83366F0C726FEE8EE634DF282FD2CE4'),('finite_cover_frontier_20261111.json','22AF246A4D7764EC9C35D22D62E4FC8E4B103900713092FAEDAEF655426384CC')]:
 need(sha(BASE/'prime-estimates'/name)==digest)
saved=json.loads((BASE/'prime-estimates/finite_cover_frontier_20261111.json').read_text())
T=989*10**24-1
need(saved['T']==T); need(T+1<2**90)
for row in saved['rows']:
 B=row['B']; K=row['ideal_minimum_new_rungs']; gap=B-2
 need(3+K*gap>=T-B)
 need(K==0 or 3+(K-1)*gap<T-B)
 need(row['full_binary_words']==(B//2-2)//64+1)
 need(row['packed_90bit_root_reserve_bytes']==(90*K+7)//8)
 need(row['pure_F_max_index_jump']==gap//2**45)
 need(row['direct_44_square_events']==44*K)
 for g in row['geometry']:
  L=2**g['ell']; E=B//2; R=E//L; last=E%L+1
  need(g['blocks']==R); need(g['last_width']==last)
  need(g['nominal_anchors']==512*R)
  need(g['tiles_excluding_initial']==(R-1)*(L//2**18)+(last+2**18-1)//2**18)
  need(F(g['ladder_to_nominal_anchor_ratio'])==F(K,512*R))
  need((L-2)+(R-1)*L+last==E-1)
for i,c in enumerate(saved['comparisons']):
 low,high=saved['rows'][i:i+2]
 dw=high['full_binary_words']-low['full_binary_words']
 dk=low['ideal_minimum_new_rungs']-high['ideal_minimum_new_rungs']
 need(c['saved_binary_words']==dw); need(c['added_ideal_rungs']==dk)
 need(F(c['ideal_rung_to_word_break_even'])==F(dw,dk))
# Enumerate all paths as an independent oracle, not the producer's DP oracle.
labels=(5,9,13,19,23,27,31); toyT=35; cases=0
for mask in range(1<<len(labels)):
 pool=(3,)+tuple(q for i,q in enumerate(labels) if mask>>i&1)
 paths=[]
 for submask in range(1<<(len(pool)-1)):
  path=(3,)+tuple(q for i,q in enumerate(pool[1:]) if submask>>i&1)
  paths.append(path)
 required=max([4,toyT-pool[-1]]+[b-a+2 for a,b in zip(pool,pool[1:])])
 for B in range(4,40,2):
  valid=[p for p in paths if p[-1]+B>=toyT and all(b-a<=B-2 for a,b in zip(p,p[1:]))]
  covered=all(any(q+4<=n<=q+B for q in pool) for n in range(7,toyT+1,2))
  need(bool(valid)==(B>=required)); need(covered==bool(valid))
  best=min((len(p)-1 for p in valid),default=None)
  greedy=[3]
  while greedy[-1]+B<toyT:
   candidates=[q for q in pool if greedy[-1]<q<=greedy[-1]+B-2]
   if not candidates: break
   greedy.append(max(candidates))
  got=len(greedy)-1 if greedy[-1]+B>=toyT else None
  need(got==best)
  weights={q:(q*7)%11 for q in pool}
  oracle=min((sum(weights[q] for q in p[1:]) for p in valid),default=None)
  dp={3:0}
  for j,q in enumerate(pool[1:],1):
   prior=[dp[a]+weights[q] for a in pool[:j] if a in dp and q-a<=B-2]
   if prior: dp[q]=min(prior)
  result=min((v for q,v in dp.items() if q+B>=toyT),default=None)
  need(oracle==result); cases+=1
out=dict(status='PASS_EXACT_GEOMETRY_COST',checks=checks,synthetic_cases=cases,
         input_pins=pins,author_sha256=sha(AUTHOR),
         scope='All paths over synthetic odd labels, weighted DP, 7 geometry rows and 6 rational tradeoffs; no prime assertions/evaluations.')
with Path(__file__).with_suffix('.json').open('x',encoding='utf8',newline='\n') as f:
 f.write(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k!='input_pins'}))
