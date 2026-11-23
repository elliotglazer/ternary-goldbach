"""Exact occupancy/price half-spaces only. No prime/function/transform evaluations."""
from pathlib import Path
import hashlib,json
BASE=Path(__file__).resolve().parents[1]
PINS={
 'prime-estimates/large_residue_bucket_occupancy_20261111.json':'19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB',
 'prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md':'99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1',
 'prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md':'55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC',
 'moebius/REVIEW_NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md':'995BADD0DDBA1F915A768DC34AAEE70BD9E356EE73A665594A6871ECAC83E234',
 'major-constants/RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md':'AFA91F89C51BFC62FAB135997C6ED9FC7FCEAE3FBF6062F973F65AE69ADAC054',
 'independent-feasibility/REVIEW_RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md':'0FC1801726CE19F28E0B512C3B24FA8D88B1531E3360E8566A1A799A8F955711'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for p,h in PINS.items(): ck(hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper()==h)
old=json.loads((BASE/next(iter(PINS))).read_text())
def ceil(a,b): return (a+b-1)//b
def buckets(c,F):
 if c<=F:return c-1
 return F-1+int(c>=2*F)+int(c>2*F)
def stats(): return dict(active_conductors=0,conductor_heights=0,R=0,B=0,A=0,core_reserve_num=0)
def add(s,w,R,B,A,reserve=0):
 s['active_conductors']+=1;s['conductor_heights']+=w
 s['R']+=w*R;s['B']+=w*B;s['A']+=w*A;s['core_reserve_num']+=w*reserve
def complete(s):
 s['operations']={'old_Horner_stages':19*s['R'],'Newton_general_products':190*s['B'],
 'wide_additions':357*s['B']+19*s['A'],'shifted_operands':357*s['B'],
 'coefficient_prescales':19*s['B'],'final_complex_rounds':s['R'],
 'bucket_setup_instances':s['B'],'conductor_band_geometry_instances':s['active_conductors'],
 'requantization_complex_round_upper_without_sharing':20*s['B']}
 return s
# Divisor inversion, not primality testing.
limit=265800;phi=list(range(limit+1))
for d in range(1,limit+1):
 for n in range(2*d,limit+1,d):phi[n]-=phi[d]
family=[]
for c in range(10001,limit+1):
 odd=c%2==1
 if not ((odd and c<=132900) or c%4==0):continue
 top=200+max(240 if odd else 255,ceil((96 if odd else 191)*3927*(531600 if odd else 1063200),(5 if odd else 10)*1250*c))
 family.append((c,phi[c],ceil(64*top,5),0 if odd else 1))
ck(len(family)==125400);ck(sum(r for c,r,last,par in family)==7133015232)
cases=[dict(general_product=p,wide_add_num=a,wide_add_den=16,final_round=f,
            scope='Core-price projection; prescales, shifts, setup, conversions, traffic and proof costs NOT zero-cost conclusions')
       for p in (1,2,4) for a in (0,1,4) for f in (0,1)]
result=[];digest=hashlib.sha256()
for scenario in old['scenarios']:
 e=scenario['extra_nodes'];bands=[]
 for b in scenario['bands']:
  F=b['fine_denominator']; lo=b['first_height_index']; hi=b['last_height_index']
  allst=[stats(),stats()];tiers={name:stats() for name in ('old_guard','new_only')}
  grids={name:[stats() for _ in cases] for name in tiers}
  for c,R,last,par in family:
   w=max(0,min(last+e,hi)-lo+1)
   if not w:continue
   B=buckets(c,F);A=c-1-B
   ck(A>=0);add(allst[par],w,R,B,A)
   if c<=10*F:continue
   tier='old_guard' if c>20*F else 'new_only'
   ck(B==F+1);add(tiers[tier],w,R,B,A)
   digest.update(f'{e},{b["band"]},{tier},{c},{R},{B},{A},{w}\n'.encode())
   for ix,case in enumerate(cases):
    p,a,f=case['general_product'],case['wide_add_num'],case['final_round']
    reserve=16*(19-f)*R-16*190*p*B-a*(357*B+19*A)
    if reserve>0:add(grids[tier][ix],w,R,B,A,reserve)
  for par in (0,1):
   src=b['cohorts'][par];s=allst[par]
   for key,target in [('active_conductors','active_conductors'),('conductor_heights','conductor_heights'),('R','unit_outputs'),('B','nonempty_bucket_heights'),('A','advance_steps')]: ck(s[key]==src[target])
  for tier in tiers:
   complete(tiers[tier])
   for case,s in zip(cases,grids[tier]):
    complete(s);o=s['operations']
    expected=16*(o['old_Horner_stages']-case['general_product']*o['Newton_general_products']-case['final_round']*o['final_complex_rounds'])-case['wide_add_num']*o['wide_additions']
    ck(expected==s['core_reserve_num']);ck(s['core_reserve_num']>=0)
  bands.append({'band':b['band'],'F':F,'guard_cohorts':tiers,'core_price_sections':grids})
 result.append({'extra_nodes':e,'bands':bands})
out={'scope':'Exact conditional price frontier, no cost adoption or runtime calibration',
      'checks':checks,'pins':PINS,'price_sections':cases,'scenarios':result,
      'row_digest':digest.hexdigest().upper(),'reserve_denominator':16,
      'full_test':'w*((19-f)*phi -190*p*B -(357*B+19*A)*a -357*B*s -19*B*v -B*k)-geometry>0',
      'requantization':'20 rounds per distinct selected source object;20B is an unshared upper schedule only'}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper(),
 'main_guards':[{'band':b['band'],'guard_cohorts':b['guard_cohorts']} for b in result[0]['bands']]}))
