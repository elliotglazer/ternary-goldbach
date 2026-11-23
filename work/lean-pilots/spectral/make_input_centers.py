"""Exact rational candidate construction, never an analytic proof or evaluator."""
from fractions import Fraction as F
from pathlib import Path
import json
from math import factorial

def ls(x):
    return 2*sum((x**(2*i+1)/F(2*i+1) for i in range(8)), F(0))
def mul(a,b):
    return (a[0]*b[0]-a[1]*b[1],a[0]*b[1]+a[1]*b[0])
def center(n):
    k=n.bit_length()-1
    l=k*ls(F(1,3))+ls(F(n-2**k,n+2**k))
    z=(-l/2,-l*F(5,64))
    power=(F(1),F(0)); out=(F(0),F(0))
    for j in range(16):
        out=tuple(out[i]+power[i]/factorial(j) for i in range(2))
        power=mul(power,z)
    m=[(x*2**20+F(1,2)).numerator//(x*2**20+F(1,2)).denominator for x in out]
    error=sum(abs(out[i]-F(m[i],2**20)) for i in range(2))
    assert error<=F(1,2**20)
    return {'n':n,'k':k,'real_numerator':m[0],'imag_numerator':m[1],
            'rounding_l1_num':error.numerator,'rounding_l1_den':error.denominator}
rows=[center(n) for n in range(1,17,2)]
tot=[sum((1 if r['n']%4==1 else -1)*r[key] for r in rows)
     for key in ['real_numerator','imag_numerator']]
value={'grid':20,'rows':rows,'signed_sum_numerators':tot,
       'scope':'rational candidates only; all analytic and arithmetic facts require Lean proofs'}
path=Path(__file__).with_name('input_centers.json')
with path.open('x',encoding='utf8') as f: json.dump(value,f,indent=2)
print([(r['n'],r['k'],r['real_numerator'],r['imag_numerator']) for r in rows])
print('signed sum',tot,'over',2**20)
