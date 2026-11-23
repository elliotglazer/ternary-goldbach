"""Exact consequences of already accepted head/count bounds; no values."""
from fractions import Fraction as F
from pathlib import Path
from math import factorial
import json
A=1500
head=F(2,14)*(F('1.668')+F(1069,A))
tail=F(12,3*A)+(80+F(187,4))/A**2
baseline=F('0.030686')+F(2,25)/36**2+F(1,10**8*36**2)
assert head<F(341,1000)
assert tail<F(3,1000)
assert head+tail<F(344,1000)<1
assert sum(F(7,5)**k/factorial(k) for k in range(13))>4
assert sum(F(5,2)**k/factorial(k) for k in range(13))>10
assert F(1,198)<F(6,1000)
assert F(22,10)+F(1,2)+F(6,1000)+F(8,1000)<3
assert baseline<F(31,1000)
out=dict(status='PASS_EXACT_CONDITIONAL_SCALARS',head_both_sign_upper=str(head),
    tail_both_sign_upper=str(tail),total_upper=str(head+tail),
    theta3_bookkeeping_upper=str(F(22,10)+F(1,2)+F(6,1000)+F(8,1000)),
    consumer_baseline_with_theta3=str(baseline),
    scope='Eight rational checks; analytic and head inputs remain named dependencies.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps(out,indent=2))
