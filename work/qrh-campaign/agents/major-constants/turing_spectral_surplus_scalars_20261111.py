"""Rational guard-budget illustrations, no signs/counts/function values."""
from fractions import Fraction as F
from pathlib import Path
import json

cmax=265800
ctmax=max(100000000,200*cmax+75000000)
labels=4333246843
b=F(42)+F(693,100)*18
rows=[]
for h, d in [(200,F(1,4)),(250,F(1,2)),(375,F(1)),(500,F(5,4))]:
    assert F(8,3)**18 > F(ctmax+cmax*h,6)
    reserve=2-d-2*b/h
    assert reserve>0
    steps=F(64*h,5)
    assert steps.denominator==1
    rows.append(dict(h=h,required_measured_D_upper=str(d),log_upper=18,
                     B_upper=str(b),strict_spectral_reserve=str(reserve),
                     extra_dense_steps=steps.numerator,
                     extra_large_branch_outputs=steps.numerator*labels))
historical=F(18397,10000)+F(621,5000)*18
assert F(ctmax+cmax*6,6)<F(8,3)**18
assert F(1,2)+2*historical/6<2
out=dict(scope='Conditional guard allocation only; measured D is not supplied',
         cT_cap=ctmax,large_labels=labels,rows=rows,
         dense_h1000_outputs=12800*labels,
         unproved_Rumely_analytic_route=dict(h=6,D_upper='1/2',B_upper=str(historical),
                                            reserve=str(2-F(1,2)-2*historical/6)))
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print('Four elementary conditional allocations and one unadopted Rumely comparison pass.')
