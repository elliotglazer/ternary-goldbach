"""Exact finite-group probability/schedule arithmetic. No candidate/root evaluations."""
from fractions import Fraction as F
from pathlib import Path
from math import prod
import hashlib,json

qs=[2,3,5,7,11,13,17,19,23,29,31]
P=prod(qs)
R=prod((F(q,q-1) for q in qs),start=F(1))
def box(x,d=12):
    z=10**d
    return [x.numerator*z//x.denominator,-((-x.numerator*z)//x.denominator),z]
def completion(failures,terms=256):
    # Max of independent geometric completion times. Distinct group components
    # are independent for a genuinely uniform unit in a cyclic prime field.
    powers=[F(1)]*len(failures)
    partial=F(0)
    for t in range(terms):
        partial+=1-prod((1-u for u in powers),start=F(1))
        powers=[u*f for u,f in zip(powers,failures)]
    rem=sum((u/(1-f) for u,f in zip(powers,failures)),F(0))
    return partial,partial+rem
def fail_after(failures,t):
    return 1-prod((1-f**t for f in failures),start=F(1))
allf=[F(1,q) for q in qs]; oddf=allf[1:]
rounds={}
for name,fs in [('all_components',allf),('odd_components',oddf),('whole_F_fresh',[1-1/R]),('odd_group_fresh',[1-2/R])]:
    lo,hi=completion(fs)
    rounds[name]={'expected_rounds_lower':box(lo),'expected_rounds_upper':box(hi),
        'failed_after_rounds':{str(t):box(fail_after(fs,t),24) for t in (8,16,32,64)}}

# Read exact masks/counts only; never import or execute the schedule producer.
root=Path(__file__).resolve().parents[1]
schedule=root/'major-constants/grouped_order_root_schedules_20261111.json'
sha=hashlib.sha256(schedule.read_bytes()).hexdigest().upper()
assert sha=='C0E1AAAC2EF8D90CAA841288ACCD5B3938DB981D3C3F3F3AC010CE37B1225BFC'
j=json.loads(schedule.read_text())
m160=next(r for r in j['rows'] if r['multiplier']==160)
partition_rows=[]
for row in m160['partitions']:
    if row['root_count'] not in (1,2,4,6,10,11): continue
    rs=[];masks=[]
    for group in row['groups']:
        mask=group['mask'];masks.append(mask)
        rs.append(prod((F(q,q-1) for n,q in enumerate(qs) if mask>>n&1),start=F(1)))
    assert sum(masks)==(1<<11)-1
    assert prod(rs,start=F(1))==R
    lo,hi=completion([1-1/r for r in rs])
    partition_rows.append({'roots':row['root_count'],'checker_ops':row['total_modular_operations'],
        'coordinates':row['root_plus_inverse_coordinates'],'masks':masks,
        'expected_group_evaluations':str(sum(rs,F(0))),
        'expected_fresh_base_rounds_lower':box(lo),'expected_fresh_base_rounds_upper':box(hi)})

F160=160*P
projection=[]
for q in qs:
    e=0;power=1
    while F160%(power*q)==0:power*=q;e+=1
    d=F160//power
    squares=d.bit_length()-1; multiplies=d.bit_count()-1
    projection.append({'q':q,'e':e,'q_power':power,'projection_exponent':d,
        'projection_squares':squares,'projection_other_products':multiplies,
        'expected_attempts':str(F(q,q-1))})
projection_sq=sum((F(q,q-1)*r['projection_squares'] for q,r in zip(qs,projection)),F(0))
projection_mu=sum((F(q,q-1)*r['projection_other_products'] for q,r in zip(qs,projection)),F(0))

out={'scope':'conditional on a true prime and uniform independent unit sampling; no prime availability claim',
 'source_schedule_sha256':sha,'R31':str(R),'component_attempts_total':str(sum((F(q,q-1) for q in qs),F(0))),
 'odd_component_attempts_total':str(sum((F(q,q-1) for q in qs[1:]),F(0))),
 'rounds':rounds,'partitions_m160':partition_rows,'individual_projection_schedule_m160':projection,
 'expected_projection_squares_no_tree_sharing':str(projection_sq),
 'expected_projection_products_no_tree_sharing':str(projection_mu)}
outpath=Path(__file__).with_suffix('.json')
with outpath.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'status':'PASS_EXACT_CONDITIONAL_MODEL','partitions':len(partition_rows),'component_schedules':len(projection)}))
