"""Count a rational Gaussian cutoff for each frequency of the fixed small-family schedule."""
from collections import Counter
from fractions import Fraction
from functools import lru_cache
from hashlib import sha256
import json
from math import gcd,isqrt
from pathlib import Path

from plan import HERE,SOURCE,budget


def ceil(a,b):
    return (a+b-1)//b


@lru_cache(None)
def powers(i):
    return 2048**i,2113**i


def conductor(c,m,N,theta):
    V=Fraction(5*m,64)
    P=Fraction(5*N,64)
    J=ceil(25*N,192)
    R=J+1
    assert V>=2*theta and 8*J < 14*P
    # pi > 157/50.  sin(t) >= t-t^3/6 for 0 <= t <= 1.
    t=2*theta/V
    D=Fraction(157,50*c)*t*(1-t*t/6)
    prefactor=2*3**21
    # Uniform full-coefficient tail bound times the total retained frequency weight 44.
    price=8*44*prefactor*(8192+1/(2*D))*4*3**theta*(1<<80)
    A=1
    while price.numerator*3**A >= price.denominator*8**A:
        A+=1
    K=isqrt((A*D.denominator-1)//D.numerator)+1
    assert K<=8192 and D*K*K >= A and D*(K-1)**2 < A
    num=32*157*64
    den=125*N
    total=Counter()
    first_empty=first_single=None
    for i in range(J*num//den+1):
        lo=ceil(i*den,num)
        hi=min(R,ceil((i+1)*den,num))
        if lo>=hi: continue
        small,large=powers(i)
        first_omitted=ceil(K*small,large)
        assert (first_omitted-1)*large < K*small <= first_omitted*large
        last=first_omitted-1
        while last and gcd(c,last)!=1:
            last-=1
        count=hi-lo
        total["frequencies"]+=count
        total["retained_integer_terms"]+=count*(first_omitted-1)
        total["recurrence_terms"]+=count*last
        total["gates"]+=count*(2*last-1 if last>=2 else 0)
        if last:
            total["nonempty"]+=count
        if last>=2:
            total["transforms"]+=count
        elif last==1 and first_single is None:
            first_single=lo
        elif last==0 and first_empty is None:
            first_empty=lo
    assert total["frequencies"]==R
    assert total["nonempty"]==first_empty and total["transforms"]==first_single
    total["old_term_budget"]=ceil(8192*(192+5*N)+192*R,192)
    return dict(c=c,A=A,K=K,N=N,theta=theta,**total)


def main():
    assert 16*(Fraction(1,5)-Fraction(1,3*5**3))-Fraction(4,239) > Fraction(157,50)
    saved=json.loads(SOURCE.read_bytes())["scenarios"][0]["small_sign_only_conditional_candidate"]
    thetas=dict(saved["conductor_theta"])
    rows=[conductor(c,m,N,thetas[c]) for c,m,N,_,_ in saved["raw_metadata"]]
    assert len(rows)==7499
    totals={k:sum(r[k] for r in rows) for k in ("frequencies","retained_integer_terms","recurrence_terms",
                                                "gates","nonempty","transforms","old_term_budget")}
    assert totals["old_term_budget"]==saved["totals"]["Gaussian_terms_upper"]
    assert totals["frequencies"]==saved["totals"]["outer_complex_exp_upper"]
    folded=Counter()
    for r in rows:
        costs,_,_=budget(r["c"],r["N"])
        for key,value in costs.items():
            q,rem=divmod(value,r["frequencies"])
            assert rem==0
            folded[key]+=q*r["transforms"]
    result=dict(totals=totals,folded_character_counts=folded,
                K_range=[min(r["K"] for r in rows),max(r["K"] for r in rows)],
                A_range=[min(r["A"] for r in rows),max(r["A"] for r in rows)],
                sha256={x.name:sha256(x.read_bytes()).hexdigest() for x in (SOURCE,Path(__file__))},rows=rows)
    (HERE/"cutoff.json").write_text(json.dumps(result,separators=(",",":"))+"\n")
    print(totals,dict(folded),result["K_range"],result["A_range"],flush=True)


if __name__=="__main__":
    main()
