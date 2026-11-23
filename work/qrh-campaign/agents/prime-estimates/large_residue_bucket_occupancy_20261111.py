"""Exact conductor/bucket metadata. No polynomial or analytic values."""
from pathlib import Path
from collections import Counter
from fractions import Fraction as Q
from math import gcd
import hashlib, json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
PINS={
 'work/qrh-blueprint/minimal_theta_nonprincipal_schedule_20261111.json':'96483C8A5E47888AC9208A8B95CA1BD8261CBC9D42AFBCBAEE1A1ABF10AC9265',
 'work/qrh-campaign/agents/major-constants/RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md':'483B6F4DC38CE5113ADF33419AEC9187BDA03A080FC7ED87ABB1727BBAAAE716',
 'work/qrh-campaign/agents/zero-sum/REVIEW_RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md':'712090B83A3C31F58C2642B329B8122661F9AB4D675F0665342D69FAD47E562D',
 'work/qrh-campaign/agents/integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md':'861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895',
 'work/qrh-campaign/agents/moebius/platt-reuse-sources/int-l-func5.11.cpp':'3D9B2B23B35129899048C23806AA42A4F2B08BE10304611AC9E1C913300FE852',
}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
def ceildiv(a,b):return (a+b-1)//b
def histogram(c,G):
 L,rem=divmod(c,G);z=Counter({L:G-rem})
 z[L+1]+=rem
 lo=c//(2*G);hi=ceildiv(c,2*G)-1
 z[lo+hi+1]-=1
 z[lo]+=1;z[hi]+=1
 z=Counter({k:v for k,v in z.items() if v})
 ck(all(k>=0 and v>0 for k,v in z.items()))
 ck(sum(z.values())==G+1)
 ck(sum(k*v for k,v in z.items())==c-1)
 return z
def bucket(a,c,G):return (2*G*a+c-1)//(2*c)
def limits(j,c,G):
 return max(1,((2*j-1)*c)//(2*G)+1), min(c-1,((2*j+1)*c)//(2*G))
def newstats():
 return dict(active_conductors=0,conductor_heights=0,unit_outputs=0,all_numerator_visits=0,
             skipped_nonunits=0,nonempty_bucket_heights=0,advance_steps=0,hist=Counter(),
             eligible_conductors=0,eligible_conductor_heights=0,eligible_units=0,
             eligible_nonempty_buckets=0,eligible_advances=0)
for p,h in PINS.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
base=json.loads((ROOT/next(iter(PINS))).read_text())

# Exact totient metadata from sum_(d|n) phi(d)=n, not a prime search.
limit=265800
phi=list(range(limit+1))
for d in range(1,limit+1):
 for multiple in range(2*d,limit+1,d):phi[multiple]-=phi[d]
family=[c for c in range(10001,limit+1) if (c%2 and c<=132900) or c%4==0]
ck(len(family)==125400 and sum(phi[c] for c in family)==7133015232)
for c in range(2,258):
 ck(phi[c]==sum(gcd(a,c)==1 for a in range(1,c)))
 for G in [2,4,8,16,32,64]:
  buckets=Counter(bucket(a,c,G) for a in range(1,c))
  expected=Counter(buckets.get(j,0) for j in range(G+1))
  ck(histogram(c,G)==expected)

examples=[]
for c,G in [(10001,1024),(10004,1024),(16384,8192),(10004,16384),(132899,1024),(265800,1024)]:
 hist=histogram(c,G);records=[]
 for j in sorted({0,1,2,G//2,G-2,G-1,G}):
  lo,hi=limits(j,c,G);units=[a for a in range(lo,hi+1) if gcd(a,c)==1]
  ck(all(bucket(a,c,G)==j for a in range(lo,hi+1)))
  records.append(dict(j=j,first=lo,last=hi,all_count=max(0,hi-lo+1),unit_count=len(units),unit_numerators=units))
 examples.append(dict(c=c,G=G,phi=phi[c],hist=dict(sorted(hist.items())),buckets=records))

scenarios=[];rowhash=hashlib.sha256()
for scen in base['scenarios']:
 e=scen['extra_nodes'];bands=scen['large']['seed_bands'];stats=[[newstats(),newstats()] for b in bands]
 for c in family:
  odd=c%2==1;cat=0 if odd else 1
  top=200+max(240 if odd else 255,
    ceildiv((96 if odd else 191)*3927*(531600 if odd else 1063200), (5 if odd else 10)*1250*c))
  last=ceildiv(64*top,5)+e
  for bi,b in enumerate(bands):
   w=max(0,min(last,b['last_index'])-b['first_index']+1)
   if not w:continue
   G=2*b['D_output'];hist=histogram(c,G);nonempty=G+1-hist.get(0,0);adv=c-1-nonempty
   ck(adv>=0 and phi[c]<=c-1)
   st=stats[bi][cat];st['active_conductors']+=1;st['conductor_heights']+=w
   st['unit_outputs']+=w*phi[c];st['all_numerator_visits']+=w*(c-1)
   st['skipped_nonunits']+=w*(c-1-phi[c]);st['nonempty_bucket_heights']+=w*nonempty
   st['advance_steps']+=w*adv
   for length,numb in hist.items():st['hist'][length]+=w*numb
   eligible=phi[c]>20*nonempty
   if eligible:
    st['eligible_conductors']+=1;st['eligible_conductor_heights']+=w
    st['eligible_units']+=w*phi[c];st['eligible_nonempty_buckets']+=w*nonempty;st['eligible_advances']+=w*adv
   rowhash.update(json.dumps([e,c,bi,w,phi[c],nonempty,adv,sorted(hist.items())],separators=(',',':')).encode())
 bandout=[]
 for bi,b in enumerate(bands):
  cohorts=[]
  for cat,st in enumerate(stats[bi]):
   R,B,A=st['unit_outputs'],st['nonempty_bucket_heights'],st['advance_steps']
   ck(st['all_numerator_visits']==R+st['skipped_nonunits']==B+A)
   ck(sum(k*v for k,v in st['hist'].items())==B+A)
   ck(sum(v for k,v in st['hist'].items() if k)>0 or B==0)
   E,EB,EA=st['eligible_units'],st['eligible_nonempty_buckets'],st['eligible_advances']
   st['hist']=dict(sorted(st['hist'].items()))
   st['model']=dict(unit_Horner_stages=19*R,reference_init_Horner_stages=380*B,
    reference_init_subtractions=190*B,reference_advance_additions=19*A,
    stage_savings_positive=R>20*B,
    required_stage_to_add_price_ratio=str(Q(10*B+A,R-20*B)) if R>20*B else None)
   st['eligible_subset_model']=dict(baseline_stages=19*E,init_stages=380*EB,
    additional_additions=190*EB+19*EA,
    required_stage_to_add_price_ratio=str(Q(10*EB+EA,E-20*EB)) if E>20*EB else None,
    scope='Necessary-screen subset only, not an accepted optimization or error proof.')
   cohorts.append(dict(conductor_parity='odd' if cat==0 else 'even',**st))
  bandout.append(dict(band=bi+1,first_height_index=b['first_index'],last_height_index=b['last_index'],
    D_output=b['D_output'],fine_denominator=2*b['D_output'],source_D=b['D_source'],cohorts=cohorts))
 R=sum(s['unit_outputs'] for row in stats for s in row)
 ck(R==scen['large']['residue_inputs'])
 ck(19*R==scen['large']['P20_Horner_stages'])
 ck(sum(s['conductor_heights'] for row in stats for s in row)==scen['large']['conductor_height_nodes'])
 scenarios.append(dict(extra_nodes=e,unit_residue_height_inputs=R,old_Horner_stages=19*R,bands=bandout))
out=dict(status='PASS_EXACT_ALL_NUMERATOR_OCCUPANCY_AND_UNIT_BASELINES',checks=checks,pins=PINS,
 family_conductors=len(family),unit_inputs_one_common_height=sum(phi[c] for c in family),examples=examples,
 scenarios=scenarios,row_digest=rowhash.hexdigest().upper(),
 scope='Exact metadata only. Every nonempty all-numerator bucket is charged even if it has no units. No unit-run pruning or stable finite-difference circuit is claimed.')
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
summary=[]
for sc in scenarios:
 rows=[]
 for b in sc['bands']:
  cc=b['cohorts'];R=sum(x['unit_outputs'] for x in cc);B=sum(x['nonempty_bucket_heights'] for x in cc);A=sum(x['advance_steps'] for x in cc)
  rows.append(dict(band=b['band'],active=sum(x['active_conductors'] for x in cc),units=R,buckets=B,advances=A,
    max_bucket=max(max(map(int,x['hist'])) if x['hist'] else 0 for x in cc),
    unit_per_bucket=str(Q(R,B)) if B else None,possible=R>20*B,
    eligible=sum(x['eligible_conductors'] for x in cc)))
 summary.append(dict(extra_nodes=sc['extra_nodes'],rows=rows))
print(json.dumps(dict(checks=checks,status=out['status'],summary=summary),indent=2))
