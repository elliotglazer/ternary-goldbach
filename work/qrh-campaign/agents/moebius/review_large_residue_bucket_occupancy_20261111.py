"""Independent exact occupancy metadata review; no function/transform values."""
from pathlib import Path
from collections import Counter
from fractions import Fraction
from math import gcd
import hashlib, json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
AUTHOR = AGENTS / 'prime-estimates/large_residue_bucket_occupancy_20261111.json'
checks = 0
def check(v):
    global checks
    assert v
    checks += 1
def ceiling(a, b):
    return -((-a)//b)

def full_hist(c, g):
    # Independent direct bucket-boundary inversion, used only on bounded examples.
    lengths = []
    for j in range(g+1):
        low = max(1, ((2*j-1)*c)//(2*g)+1)
        high = min(c-1, ((2*j+1)*c)//(2*g))
        lengths.append(max(0, high-low+1))
    return Counter(lengths)

def fast_hist(c, g):
    q, r = divmod(c, g)
    z = Counter({q:g-r, q+1:r})
    left = c//(2*g)
    right = (c-1)//(2*g)
    z[left+right+1] -= 1
    z[left] += 1
    z[right] += 1
    return Counter({k:v for k,v in z.items() if v})

def main():
    data = json.loads(AUTHOR.read_text(encoding='utf-8'))
    # Mobius inversion of the divisor identity, not a prime or factor catalogue.
    bound = 265800
    mu = [0]*(bound+1)
    mu[1] = 1
    for d in range(1,bound+1):
        for n in range(d+d,bound+1,d):
            mu[n] -= mu[d]
    phi = [0]*(bound+1)
    for d in range(1,bound+1):
        if mu[d]:
            for n in range(d,bound+1,d):
                phi[n] += mu[d]*(n//d)
    family = list(range(10001,132900,2)) + list(range(10004,265801,4))
    check(len(family)==125400)
    check(sum(phi[c] for c in family)==7133015232)
    for c in range(2,130):
        check(phi[c]==sum(gcd(a,c)==1 for a in range(1,c)))
    samples = [10001,10004,16384,32768,132899,265800]
    for c in samples:
        for g in [1024,2048,4096,8192,16384]:
            check(full_hist(c,g)==fast_hist(c,g))
    for item in data['examples']:
        c,g=item['c'],item['G']
        check(phi[c]==item['phi'])
        check({str(k):v for k,v in sorted(full_hist(c,g).items())}==item['hist'])
        for b in item['buckets']:
            j=b['j']
            lo=max(1,((2*j-1)*c)//(2*g)+1)
            hi=min(c-1,((2*j+1)*c)//(2*g))
            units=[a for a in range(lo,hi+1) if gcd(a,c)==1]
            check((lo,hi,max(0,hi-lo+1),len(units),units)==
                  (b['first'],b['last'],b['all_count'],b['unit_count'],b['unit_numerators']))
            check(all((2*j-1)*c<2*g*a<=(2*j+1)*c for a in range(lo,hi+1)))
    all_summaries=[]
    starts=[0,6401,12801,25601,64001]
    ends=[6400,12800,25600,64000]
    gs=[1024,2048,4096,8192,16384]
    for scenario in data['scenarios']:
        extra=scenario['extra_nodes']
        all_r=all_heights=0
        brief=[]
        for bi,g in enumerate(gs):
            first,last=starts[bi], (ends[bi] if bi<4 else 84199+extra)
            row=scenario['bands'][bi]
            check((row['first_height_index'],row['last_height_index'],row['fine_denominator'])==(first,last,g))
            cohort_summaries=[]
            for parity in ['odd','even']:
                totals=Counter()
                hist=Counter()
                for c in family:
                    odd=c%2==1
                    if odd!=(parity=='odd'):continue
                    # One exact ceiling over the full rational height expression.
                    numerator=(96 if odd else 191)*3927*(531600 if odd else 1063200)
                    denom=(5 if odd else 10)*1250*c
                    height=ceiling(max((200+(240 if odd else 255))*denom,200*denom+numerator),denom)
                    count=ceiling(64*height,5)+1+extra
                    w=max(0,min(count,last+1)-first)
                    if not w:continue
                    b=min(c-1,g-1)+int(c>=2*g)+int(c>2*g)
                    a=c-1-b
                    h=fast_hist(c,g)
                    check(b==sum(v for k,v in h.items() if k>0))
                    totals.update(active_conductors=1,conductor_heights=w,unit_outputs=w*phi[c],
                        all_numerator_visits=w*(c-1),skipped_nonunits=w*(c-1-phi[c]),
                        nonempty_bucket_heights=w*b,advance_steps=w*a)
                    for length,n in h.items():hist[length]+=w*n
                    if phi[c]>20*b:
                        totals.update(eligible_conductors=1,eligible_conductor_heights=w,
                            eligible_units=w*phi[c],eligible_nonempty_buckets=w*b,eligible_advances=w*a)
                saved=next(x for x in row['cohorts'] if x['conductor_parity']==parity)
                fields=['active_conductors','conductor_heights','unit_outputs','all_numerator_visits',
                        'skipped_nonunits','nonempty_bucket_heights','advance_steps','eligible_conductors',
                        'eligible_conductor_heights','eligible_units','eligible_nonempty_buckets','eligible_advances']
                for name in fields:check(totals[name]==saved[name])
                check({str(k):v for k,v in sorted(hist.items())}==saved['hist'])
                r,b,a=(totals[k] for k in ['unit_outputs','nonempty_bucket_heights','advance_steps'])
                expected=dict(unit_Horner_stages=19*r,reference_init_Horner_stages=380*b,
                    reference_init_subtractions=190*b,reference_advance_additions=19*a,
                    stage_savings_positive=r>20*b,
                    required_stage_to_add_price_ratio=str(Fraction(10*b+a,r-20*b)) if r>20*b else None)
                check(expected==saved['model'])
                er,eb,ea=(totals[k] for k in ['eligible_units','eligible_nonempty_buckets','eligible_advances'])
                em=saved['eligible_subset_model']
                for name,val in dict(baseline_stages=19*er,init_stages=380*eb,
                    additional_additions=190*eb+19*ea,
                    required_stage_to_add_price_ratio=str(Fraction(10*eb+ea,er-20*eb)) if er>20*eb else None).items():
                    check(em[name]==val)
                all_r+=r;all_heights+=totals['conductor_heights']
                cohort_summaries.append(dict(parity=parity,units=r,buckets=b,advances=a))
            brief.append(dict(band=bi+1,cohorts=cohort_summaries))
        check(all_r==scenario['unit_residue_height_inputs'])
        check(19*all_r==scenario['old_Horner_stages'])
        all_summaries.append(dict(extra=extra,unit_inputs=all_r,conductor_heights=all_heights,bands=brief))
    out=dict(status='PASS_INDEPENDENT_EXACT_OCCUPANCY_METADATA',checks=checks,
        author_receipt_sha256=hashlib.sha256(AUTHOR.read_bytes()).hexdigest().upper(),
        scope='All aggregate integer fields/histograms/cost ratios reconstructed; no function values, circuit/error admission or runtime claim.',
        summaries=all_summaries)
    dest=HERE/'review_large_residue_bucket_occupancy_20261111.json'
    with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
    print(json.dumps({'status':out['status'],'checks':checks}))

if __name__=='__main__':main()
