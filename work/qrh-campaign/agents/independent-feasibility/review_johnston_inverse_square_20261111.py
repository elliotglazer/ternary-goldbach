"""Exact supplement for the three-unit explicit-formula allowance. No evaluator."""
from fractions import Fraction as F
from pathlib import Path
import json

checks={}
def ck(k,v):
    assert v,k
    checks[k]=True
head=F(2,14)*(F(417,250)+F(1069,1500))
tail=F(12,4500)+(80+F(187,4))/1500**2
ck('head_identity',head==F(3571,10500))
ck('tail_identity',tail==F(2723,10**6))
ck('sum_identity',head+tail==F(7199183,21000000))
ck('inverse_square_lt_0344',head+tail<F(43,125)<1)
ck('constant_sum',F(1,2)+F(11,5)+F(3,500)+F(1,125)<3)
ck('trivial_zero_term',F(1,198)<F(3,500))
ck('formula_domain',36>F(2,4*F(23,10)))
eps=F(1,10000)
res=F(201,100)*eps*F(10003,10000)/36+F(5,2)*F(10003,10000)/(10**8*36)+F(3,10**8*36**2)+F(1,2*10**8*36)
ck('residual_with_three',res<F(3,500000))
ck('allocation_with_three',F(71,2500)+F(9,10000)+F(3,50000)+F(3,500000)+F(33,25000)+F(1,12960)<F(31,1000))
out={'scope':'exact scalar supplement only','checks':checks,'check_count':len(checks),'head':str(head),'tail':str(tail),'residual_upper':str(res)}
path=Path(__file__).with_suffix('.json')
with path.open('x',encoding='utf-8') as f:
    json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'status':'PASS','checks':len(checks)}))
