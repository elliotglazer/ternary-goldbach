"""Independent rational-envelope reconstruction; no source coefficient evaluations."""
from fractions import Fraction as Q
from math import comb, factorial
from functools import lru_cache
from pathlib import Path
import json
import hashlib

ROOT = Path(__file__).resolve().parents[4]
AGENTS = ROOT / 'work/qrh-campaign/agents'
U = Q(1, 2**100)
W = 4*U + Q(330,2**110)
FLAT = 2**27*(U/4+Q(330,2**110))
REM = Q(1,2**116)

def original_bound(cohort, degree):
    if cohort == 'first_four':
        if degree == 0:
            return Q(5170)+REM+W
        return 6*Q(5,4)**degree/factorial(degree)+min(4**degree*W,FLAT)
    if degree == 0:
        return Q(4507)+Q(9,2)+REM+U
    return Q(15,2)*Q(7,8)**degree/factorial(degree)+U

def converted(cohort,degree):
    return original_bound(cohort,degree)+3*U/4

@lru_cache(None)
def finite_kernel(degree,order,step):
    # The actual finite jth difference of x^degree at positive x=1/4.
    # This reconstructs the positive majorant without Stirling recursion.
    return sum(((-1)**(order-k)*comb(order,k)*(Q(1,4)+k*step)**degree
                for k in range(order+1)),Q(0))

def guarded(cohort,i,j,step):
    return sum((converted(cohort,19-i+ell)*finite_kernel(ell,j,step)
                for ell in range(j,i+1)),Q(0))

def incell(cohort,i,j):
    # First annihilate the low powers, then use all in-cell support values.
    return 2**j*sum((converted(cohort,19-i+ell)/4**ell
                     for ell in range(j,i+1)),Q(0))

def strict_power(x):
    assert x>0
    e=x.numerator.bit_length()-x.denominator.bit_length()
    def power(e):return Q(2**e) if e>=0 else Q(1,2**(-e))
    while not x<power(e):e+=1
    while x<power(e-1):e-=1
    return e

def ceiling_power(x):
    e=strict_power(x)
    power=Q(2**(e-1)) if e>=1 else Q(1,2**(1-e))
    return e-1 if x==power else e

def reconstruct():
    rows=[]
    for cohort in ('first_four','final'):
        for domain,step in (('ten',Q(1,20)),('twenty',Q(1,40)),('all_cell',None)):
            E=(lambda i,j:incell(cohort,i,j)) if step is None else (lambda i,j:guarded(cohort,i,j,step))
            for i in range(20):
                for j in range(i+1):
                    state=E(i,j)
                    if i==0:
                        gen=secondary=insert=Q(0)
                    elif j==0:
                        gen=E(i-1,0)/4
                        secondary=Q(0)
                        insert=converted(cohort,19-i)
                    elif j==i:
                        gen=insert=Q(0)
                        secondary=(Q(1,2) if step is None else j*step)*E(i-1,j-1)
                    else:
                        gen=(Q(1,4) if step is None else Q(1,4)+j*step)*E(i-1,j)
                        secondary=(Q(1,2) if step is None else j*step)*E(i-1,j-1)
                        insert=Q(0)
                    raw=gen+secondary+insert
                    rows.append(dict(cohort=cohort,domain=domain,i=i,j=j,
                                     state=state,general=gen,secondary=secondary,insertion=insert,raw_sum=raw))
    return rows

def read_pinned(path,expected):
    data=path.read_bytes()
    assert hashlib.sha256(data).hexdigest().upper()==expected
    return json.loads(data)

def main():
    paths={
      'major-constants/STAGEWISE_NEWTON_COEFFICIENT_WIDTHS_2026-11-11.md':'61A6DD47B1F86391BA731DAB7A97D2408D54C710BBDF34EA95C36FFD9762F7A0',
      'major-constants/stagewise_newton_widths_20261111.py':'E34B2EAB9B5B0DA49A9F61D7AA47D6D1316E74A24071BD9726B72C3D0B4A50F0',
      'major-constants/stagewise_newton_widths_20261111.json':'717D0A360AC84F0FE327F30C18B4821CF700054521B602FADCD6D49F44F0276C',
    }
    checks=0
    def check(condition):
        nonlocal checks
        assert condition
        checks+=1
    for rel,h in paths.items():
        check(hashlib.sha256((AGENTS/rel).read_bytes()).hexdigest().upper()==h)
    author=json.loads((AGENTS/'major-constants/stagewise_newton_widths_20261111.json').read_text())
    for rel,h in author['pins'].items():
        check(hashlib.sha256((AGENTS/rel).read_bytes()).hexdigest().upper()==h)
        paths[rel]=h
    src=json.loads((AGENTS/'prime-estimates/stored_hurwitz_degree_bounds_20261111.json').read_text())
    for cohort in ('first_four','final'):
        for k,row in enumerate(src['cohorts'][cohort]):
            check(Q(row['stored_center_norm_bound'])==original_bound(cohort,k))
            check(Q(author['rows'][cohort]['converted_coefficient_bounds'][k])==converted(cohort,k))
    def descriptor(rec,value,i):
        check(Q(rec['norm_bound'])==value)
        q=ceiling_power(value)
        power=Q(2**q) if q>=0 else Q(1,2**(-q))
        check(power/2<value<=power)
        r=(531600**i-1).bit_length()
        check(rec['binary_exponent']==q)
        check(rec['max_v_power_exponent']==r)
        check(rec['signed_integer_bits_at_vmax']==max(1,101+r+q))
    rows=reconstruct()
    summary={}
    for row in rows:
        cohort,i,j=row['cohort'],row['i'],row['j']
        domain={'ten':'guard10','twenty':'guard20','all_cell':'all_cell'}[row['domain']]
        stage=author['rows'][cohort]['domains'][domain][i]
        state=stage['states'][j]
        check(stage['coefficient_indices']==list(range(19-i,20)))
        Ci=max(converted(cohort,k) for k in range(19-i,20))
        check(Q(stage['C_i'])==Ci)
        check(state['order']==j)
        descriptor(state,row['state'],i)
        ref=Q(4,3)*Ci*(2**j if domain=='all_cell' else 1)
        check(row['state']<ref)
        check(state['max_C_i_reference_signed_bits']==max(1,101+(531600**i-1).bit_length()+ceiling_power(ref)))
        if i:
            raw=stage['raw_updates'][j]
            check(raw['order']==j)
            check(raw['kind']==('coefficient_insertion' if j==0 else 'new_top' if j==i else 'interior'))
            if row['general']:
                descriptor(raw['general'],row['general'],i)
            else:
                check(raw['general'] is None)
            descriptor(raw['secondary_or_insert'],row['secondary']+row['insertion'],i)
            descriptor(raw['raw_absolute_sum'],row['raw_sum'],i)
            check(row['raw_sum']<ref)
            if j==0:
                check(row['raw_sum']==row['state'])
        if j==0:
            descriptor(stage['new_coefficient'],converted(cohort,19-i),i)
            check(stage['peak_state_signed_bits']==max(s['signed_integer_bits_at_vmax'] for s in stage['states']))
            check(stage['peak_raw_signed_bits']==max([s['raw_absolute_sum']['signed_integer_bits_at_vmax'] for s in stage['raw_updates']] or [stage['states'][0]['signed_integer_bits_at_vmax']]))
            summary.setdefault(cohort,{}).setdefault(domain,[]).append([i,stage['peak_state_signed_bits'],stage['peak_raw_signed_bits']])
    # Directly check the forward-difference monomial identity and positivity;
    # all terms are formal rational majorants, not actual source polynomials.
    for step in (Q(1,20),Q(1,40)):
        for degree in range(20):
            for order in range(20):
                k=finite_kernel(degree,order,step)
                check(k>=0)
                if order>degree:check(k==0)
    result={
      'scope':'Independent rational envelopes and saved-data widths; no actual coefficient or function evaluation',
      'checks':checks,'pins':paths,'source_coefficients_reconstructed':40,
      'state_rows_compared':len(rows),'raw_update_rows_compared':sum(r['i']>0 for r in rows),
      'independent_method':'Alternating finite-binomial monomial differences, not author Stirling recursion; source Z independently reconstructed.',
      'stage_peaks':summary,
      'limits':['All-cell rows require j<L.','Normalized circuit domains/divisibility remain separate.','No width-to-runtime or cost winner inference.'],
    }
    out=Path(__file__).with_suffix('.json')
    with out.open('x',encoding='utf-8') as f:
        json.dump(result,f,indent=2); f.write('\n')
    print(json.dumps({'checks':checks,'states':len(rows),'sha256':hashlib.sha256(out.read_bytes()).hexdigest().upper()}))

if __name__=='__main__':
    main()
