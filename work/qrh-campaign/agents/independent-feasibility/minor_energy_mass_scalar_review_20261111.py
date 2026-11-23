"""Independent finite rational checks; reads old table, imports no author code."""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial, isqrt
import hashlib
import json
import re

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent

def digest(p):
    return hashlib.sha256(p.read_bytes()).hexdigest().upper()

def partial_exp(q, count):
    term = Q(1)
    answer = term
    for j in range(1, count):
        term = term*q/j
        answer += term
    return answer

def main():
    src = AGENTS/'prime-estimates/XiMass.lean'
    table_text = src.read_text(encoding='utf-8').split('private def logTable')[1].split('\n]')[0]
    entries = [(int(a),int(b)) for a,b in re.findall(r'\((\d+), (\d+)\)',table_text)]
    table = dict(entries)
    assert len(entries)==len(table)==303
    eup = Q(27182818286,10**10)
    elo = Q(27182818283,10**10)
    for p, c in entries:
        assert p>=2 and all(p%d for d in range(2,isqrt(p)+1))
        a, r = divmod(c,10**6)
        f=Q(r,10**6)
        assert eup**a*(partial_exp(f,12)+f**12*Q(13,12*factorial(12))) <= p
    total=Q(0)
    powers=[]
    for n in range(2,2001):
        p=next((d for d in range(2,isqrt(n)+1) if n%d==0),n)
        residual=n
        while residual%p==0:
            residual//=p
        if residual==1:
            assert p in table
            total+=Q(table[p],10**6*n*n)
            powers.append(n)
    assert len(powers)==333 and total>Q(56945,10**5)
    harmonic=sum((Q(1,j) for j in range(1,1001)),Q(0))
    assert harmonic>=Q(748547086,10**8)
    a,r=divmod(6908755,10**6)
    assert 1001<elo**a*partial_exp(Q(r,10**6),12)
    assert Q(748547086,10**8)-Q(6908755,10**6)>Q(576715,10**6)
    mass=Q(3,2)-Q(11447,20000)-Q(576715,2*10**6)-Q(56945,10**5)
    assert mass==Q(698425,10**7)<Q(7,100)
    # Scalar maxima, kernel numerators, all-x endpoint bounds.
    for k,cap in enumerate([Q(1,2),Q(1),Q(3),Q(10)]):
        assert partial_exp(Q(2*k+3),31)>Q(2*k+3,2)**(2*k+3)/cap**2
    numerator1=2*(Q(39,2)+2*Q(96,5))/2+4*2*Q(9,2)*2+4*Q(31,2)
    fp=2*2*Q(9,2)/2+4*2
    numerator2=2*(Q(39,2)+2*Q(96,5))+4*2*Q(9,2)*7+4*58+2*fp
    assert numerator1==Q(1919,10)<172*Q(9,8)
    assert numerator2==Q(3169,5)<566*Q(9,8)
    x0=49*10**25
    assert 2125**8<x0 and eup**61<x0
    vertical1=16703*8*eup
    vertical2=2*vertical1*eup
    assert vertical1<400000 and vertical2<2200000
    assert Q(400000)*Q(66403,10000)*10**6/6<5*10**11
    assert Q(2200000)*Q(66403,10000)*10**6/6<3*10**12
    assert Q(5*10**11)+Q(3*10**12,61)<6*10**11
    assert (6*10**38)**2<x0**3  # 6e11*x0^-3/2 < 1e-27
    err=Q(7,100*2125)*(172+Q(566,61))
    assert err+Q(1,10**27)<Q(6,1000)
    energy=Q(640206,10**6)+Q(195,10**8)+Q(53,10**8*61)+Q(6,1000)
    assert energy<Q(64621,10**5)<Q(65,100)
    result={'status':'PASS_EXACT_FINITE_ARITHMETIC_ONLY','old_XiMass_sha256':digest(src),
            'checked_prime_log_lower_bounds':303,'checked_prime_power_terms':333,
            'mass_upper':str(mass),'mass_slack':str(Q(7,100)-mass),
            'zero_error_upper':str(err),'energy_coefficient_upper':str(energy),
            'analytic_scope':'Source/paper argument is separate. No exp/log oracle or author import.'}
    out=Path(__file__).with_suffix('.json')
    with out.open('x',encoding='utf-8') as f:
        json.dump(result,f,indent=2)
        f.write('\n')
    print(json.dumps({'status':result['status'],'receipt_sha256':digest(out)}))

if __name__=='__main__':
    main()
