"""Independent finite integer occupancy and linear-price check. No evaluations."""
from pathlib import Path
from collections import Counter
import hashlib, json

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
SOURCE=AGENTS/'major-constants/newton_cost_frontier_20261111.json'
checks=0
def ck(x):
    global checks
    assert x
    checks+=1
def ceil(a,b): return -((-a)//b)

def main():
    doc=json.loads(SOURCE.read_text(encoding='utf-8'))
    for p,h in doc['pins'].items():
        ck(hashlib.sha256((AGENTS/p).read_bytes()).hexdigest().upper()==h)
    # Independent Mobius inversion of the divisor identity.
    cap=265800
    mu=[0]*(cap+1); mu[1]=1
    for d in range(1,cap+1):
        for n in range(d+d,cap+1,d): mu[n]-=mu[d]
    phi=[0]*(cap+1)
    for d in range(1,cap+1):
        if mu[d]:
            for n in range(d,cap+1,d): phi[n]+=mu[d]*(n//d)
    family=list(range(10001,132900,2))+list(range(10004,265801,4))
    ck(len(family)==125400)
    ck(sum(phi[c] for c in family)==7133015232)
    cases=doc['price_sections']
    ck([(v['general_product'],v['wide_add_num'],v['wide_add_den'],v['final_round']) for v in cases]
       ==[(p,a,16,f) for p in (1,2,4) for a in (0,1,4) for f in (0,1)])
    examples=[]
    for scenario in doc['scenarios']:
        extra=scenario['extra_nodes']
        for bi,band in enumerate(scenario['bands']):
            g=2**(10+bi)
            ck(g==band['F'])
            first=[0,6401,12801,25601,64001][bi]
            last=[6400,12800,25600,64000,84199+extra][bi]
            sums={tier:[Counter() for _ in range(19)] for tier in ('old_guard','new_only')}
            for c in family:
                odd=c%2==1
                den=(5 if odd else 10)*1250*c
                num=(96 if odd else 191)*3927*(531600 if odd else 1063200)
                h=ceil(max((200+(240 if odd else 255))*den,200*den+num),den)
                w=max(0,min(ceil(64*h,5)+extra,last)-first+1)
                if w==0 or c<=10*g: continue
                tier='old_guard' if c>20*g else 'new_only'
                b=min(c-1,g-1)+int(c>=2*g)+int(c>2*g)
                ck(b==g+1)
                r,a=phi[c],c-1-b
                ck(a>=0 and r<=b+a)
                values=dict(active_conductors=1,conductor_heights=w,R=w*r,B=w*b,A=w*a)
                sums[tier][0].update(values)
                for i,case in enumerate(cases,1):
                    p,f,an=case['general_product'],case['final_round'],case['wide_add_num']
                    # Multiply the complete projected inequality by16 before testing.
                    reserve=304*r-3040*p*b-16*f*r-an*(357*b+19*a)
                    if reserve>0:
                        sums[tier][i].update(values)
                        sums[tier][i]['core_reserve_num']+=w*reserve
            for tier,rows in sums.items():
                saved=[band['guard_cohorts'][tier]]+band['core_price_sections'][tier]
                for row,got in zip(rows,saved):
                    for k in ('active_conductors','conductor_heights','R','B','A','core_reserve_num'):
                        ck(row[k]==got[k])
                    r,b,a=row['R'],row['B'],row['A']
                    expected=dict(old_Horner_stages=19*r,Newton_general_products=190*b,
                        wide_additions=357*b+19*a,shifted_operands=357*b,coefficient_prescales=19*b,
                        final_complex_rounds=r,bucket_setup_instances=b,
                        conductor_band_geometry_instances=row['active_conductors'],
                        requantization_complex_round_upper_without_sharing=20*b)
                    ck(expected==got['operations'])
                examples.append(dict(extra=extra,band=bi+1,tier=tier,
                    conductors=rows[0]['active_conductors'],R=rows[0]['R'],B=rows[0]['B'],A=rows[0]['A']))
    # Width and initialization count facts, checked without any coefficient values.
    ck((2*265800)**19 < 2**362)
    ck(sum(range(1,20))==190)
    ck(sum((20-j)*(j.bit_count()-1) for j in range(1,20))==167)
    ck(sum((20-j)*j.bit_count() for j in range(1,20))==357)
    out=dict(status='PASS_EXACT_METADATA_ONLY',checks=checks,
        author_receipt_sha256=hashlib.sha256(SOURCE.read_bytes()).hexdigest().upper(),
        scope='All40 guard cohorts and720 projected price subsets independently reconstructed; no prices calibrated or savings adopted.',
        guard_cohorts=examples)
    dest=HERE/'review_newton_cost_frontier_20261111.json'
    with dest.open('x',encoding='utf-8') as f: json.dump(out,f,indent=2);f.write('\n')
    print(json.dumps({'status':out['status'],'checks':checks}))

if __name__=='__main__': main()
