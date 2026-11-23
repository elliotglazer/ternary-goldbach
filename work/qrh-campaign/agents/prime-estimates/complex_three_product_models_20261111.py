"""Symbolic polynomial and integer cost checks; no transform/function evaluation."""
from fractions import Fraction as F
from pathlib import Path
import json
def var(i): return {tuple(int(j==i) for j in range(4)):1}
def add(p,q):
    r=p.copy()
    for m,c in q.items(): r[m]=r.get(m,0)+c
    return {m:c for m,c in r.items() if c}
def neg(p): return {m:-c for m,c in p.items()}
def sub(p,q): return add(p,neg(q))
def mul(p,q):
    r={}
    for m,c in p.items():
        for n,d in q.items():
            k=tuple(x+y for x,y in zip(m,n)); r[k]=r.get(k,0)+c*d
    return {m:c for m,c in r.items() if c}
a,b,c,d=[var(i) for i in range(4)]
re=sub(mul(a,c),mul(b,d)); im=add(mul(a,d),mul(b,c))
gauss=mul(add(a,b),add(c,d))
t=mul(c,add(a,b)); u=mul(b,add(c,d)); v=mul(a,sub(d,c))
assert sub(t,u)==re and add(t,v)==im
assert sub(sub(gauss,mul(a,c)),mul(b,d))==im
assert add(t,mul(a,sub(c,d)))!=im  # real sign/index mutation
td=mul(d,sub(a,b))
assert add(td,mul(a,sub(c,d)))==re
assert add(td,mul(b,add(c,d)))==im
def M(n,m): return 5*n*m+2*min(n,m)+1
def A(n): return 2*n+1
rows=[]
for radix in [4,8,10,12,16]:
    for p in [128,192,256,512,1024]:
        n=(p+radix-1)//radix; grown=(p+1+radix-1)//radix
        four=4*M(n,n); fixed=3*M(n,grown); three=2*M(n,n)+M(grown,grown)
        rows.append(dict(radix_bits=radix,p=p,n=n,grown_n=grown,
            four_product_events=four,fixed_three_product_events=fixed,gauss_product_events=three,
            four_with_runtime_add_skeleton=four+2*A(grown),
            fixed_with_runtime_add_skeleton=fixed+3*A(grown),
            gauss_with_runtime_add_skeleton=three+5*A(grown),
            raw_standard_product_bits=2*p,raw_fixed_product_bits=2*p+1,
            raw_gauss_largest_product_bits=2*p+2))
budget_checks=[]
for AA,BB in [(F(1),F(1)),(F(100),F(400)),(F(1,16),F(7,8))]:
    E=F(1,2**20)
    es=E/(8*max(F(1),BB)); eta=E/(8*max(F(1),AA)); eg=E/4
    bound=BB*es+AA*eta+3*eg
    assert bound<=E
    budget_checks.append(dict(A=str(AA),B=str(BB),target=str(E),bound=str(bound)))
out=dict(scope='symbolic identities and proof-template sizing, no precision/throughput conclusion',
    symbolic_identities_passed=5,sign_mutation_rejected=True,rows=rows,budget_checks=budget_checks)
if __name__=='__main__':
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    for r in rows:
        if r['radix_bits']==8: print(r['p'],r['four_product_events'],r['fixed_three_product_events'],r['gauss_product_events'])
