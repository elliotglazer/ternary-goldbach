"""Exact envelope arithmetic only; no Hurwitz/exp/trig/jet values or transforms."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import json
bands=[(500,512,220),(1000,1024,387),(2000,2048,720),(5000,4096,1720),(10000,8192,3387)]
eta=F(1,2**100); delta=F(1,2**118); u=F(1,2**122)
rows=[]
for V,D,N in bands:
    assert N==(V+160+2)//3
    a=F(V+32,D)
    assert a<F(5,4)
    assert F(6,D)<1
    b=N+2
    # The original uniform EM bound, using sqrt(b)<=b.
    remainder=F(108*b,1)/F(255,2)/2**128
    assert remainder<F(1,2**116)
    for P in [20,24,27,28,32]:
        max_r=max(F(5,4)**k/F(factorial(k)) for k in range(P))
        assert max_r<=F(5,4)
        head_delta=5*N
        head_u=5*N*P+3*N+1
        endpoint_delta=2*b+1
        endpoint_u=2*(8*b+127)+1
        total=(head_delta+endpoint_delta)*delta+(head_u+endpoint_u+1)*u+remainder
        assert total<eta/4
        C=3*N+5
        assert 4*C+1<2**16
        rows.append(dict(V=V,D=D,N=N,P=P,remainder=str(remainder),
            head_delta_coefficient=head_delta,head_u_coefficient=head_u,
            endpoint_delta_coefficient=endpoint_delta,endpoint_u_coefficient=endpoint_u,
            seed_error=str(total),seed_error_over_eta=str(total/eta),shift_center_bound=4*C+1))
shift=[]
for P in [27,28,32]:
    L=20*P-210
    target=F(1266)*F(5,16)**20/factorial(20)
    tail=F(1266)*F(15,16)**P/factorial(P)
    seed=2532*eta
    rounding=633*L*F(1,2**110)
    horner=1688*F(1,2**100)
    total=target+tail+seed+rounding+horner
    assert total<F(1,2**82)
    assert 2**P*(eta+L*F(1,2**110))<1
    shift.append(dict(P=P,L=L,target=str(target),shift_tail=str(tail),
        seed=str(seed),rounding=str(rounding),horner=str(horner),total=str(total),
        budget_fraction=str(total*2**82)))
worst=23714*delta+606562*u+F(1,2**116)
assert worst<eta/4
assert 10000*F(1,2**135)<delta/8
out=dict(scope='rational envelope and metadata calculations only',eta=str(eta),base_leaf_delta=str(delta),
         internal_round_u=str(u),worst_uniform_bound=str(worst),worst_over_eta=str(worst/eta),rows=rows,shift=shift)
if __name__=='__main__':
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    print('25 seed allocations and 3 complete alpha budgets pass; worst/eta =',worst/eta)
