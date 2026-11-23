"""Independent exact scalar checks only; no theta or spectral evaluation."""
from fractions import Fraction as F
from pathlib import Path
import json

assert F(3,5)**2+F(1,2)**2 == F(61,100)
rows=[]
for T in (1000000,60343058):
    n=0
    while 2*100**n < (T+1)*61**n:
        n+=1
    assert 2*100**n >= (T+1)*61**n
    assert n == 0 or 2*100**(n-1) < (T+1)*61**(n-1)
    rows.append({'height':T,'least_sufficient_inversions':n,
                 'sufficient_margin':str(2*100**n-(T+1)*61**n),
                 'predecessor_deficit':str((T+1)*61**(n-1)-2*100**(n-1))})
assert [r['least_sufficient_inversions'] for r in rows] == [27,35]
result={'status':'PASS','scope':'Exact reduction growth and two integer inversion-count bounds only; no theta evaluation.',
        'norm_square_cap':'61/100','cases':rows}
Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(result,indent=2))
