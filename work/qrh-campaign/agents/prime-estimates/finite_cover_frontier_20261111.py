"""Integer geometry only. No primality tests, sieve, analytic values or builds."""
from fractions import Fraction
from pathlib import Path
from itertools import combinations
import json

N0 = 989 * 10**24
T = N0 - 1
F = 2**45
assert N0 < F*F

def ceildiv(a, b):
    return -((-a)//b)

rows = []
for B in [10**15, 2*10**15, 10**16, 2*10**16, 10**17, 2*10**17, 4*10**18]:
    k = max(0, ceildiv(T-B-3, B-2))
    words = ceildiv(B//2-1, 64)
    geom = []
    for ell in [32,34,36]:
        L=2**ell; E=B//2; R=E//L; last=E-R*L+1
        assert (L-2)+(R-1)*L+last == E-1
        C=(R-1)*ceildiv(L,2**18)+ceildiv(last,2**18)
        anchors=512*R
        geom.append(dict(ell=ell,blocks=R,last_width=last,nominal_anchors=anchors,
                         tiles_excluding_initial=C,
                         ladder_to_nominal_anchor_ratio=str(Fraction(k,anchors))))
    rows.append(dict(B=B,ideal_minimum_new_rungs=k,full_binary_words=words,
                     pure_F_max_index_jump=(B-2)//F,
                     direct_44_square_events=44*k,
                     packed_90bit_root_reserve_bytes=ceildiv(90*k,8),
                     geometry=geom))

comparisons=[]
for lo,hi in zip(rows,rows[1:]):
    dw=hi['full_binary_words']-lo['full_binary_words']
    dk=lo['ideal_minimum_new_rungs']-hi['ideal_minimum_new_rungs']
    assert dw>0 and dk>0
    comparisons.append(dict(B_low=lo['B'],B_high=hi['B'],saved_binary_words=dw,
                            added_ideal_rungs=dk,
                            ideal_rung_to_word_break_even=str(Fraction(dw,dk))))

# Exhaustive finite geometry sanity checks on odd endpoint labels, NOT primes.
# The mathematical proof does not rely on these toy instances.
base=[9,15,19,27,35,43,51]
checks=0
for size in range(8):
    for subset in combinations(base,size):
        pool=(3,)+subset
        toyT=57
        required=max([4,toyT-pool[-1]]+[pool[i]-pool[i-1]+2 for i in range(1,len(pool))])
        for B in range(4,60,2):
            inf=1000
            costs=[0]+[inf]*(len(pool)-1)
            for j in range(1,len(pool)):
                costs[j]=min([costs[i]+1 for i in range(j) if pool[j]-pool[i]<=B-2]+[inf])
            best=min([costs[i] for i in range(len(pool)) if pool[i]+B>=toyT]+[inf])
            assert (best<inf)==(B>=required)
            p=3; greedy=0
            while p+B<toyT:
                candidates=[q for q in pool if p<q<=p+B-2]
                if not candidates:
                    greedy=inf; break
                p=max(candidates);greedy+=1
            assert greedy==best
            checks+=1

out=dict(scope='exact geometry and symbolic cost coefficients; no prime data',N0=N0,T=T,
         F=F,rows=rows,comparisons=comparisons,synthetic_odd_label_geometry_checks=checks)
if __name__=='__main__':
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    print('Geometry checks:',checks)
    for r in rows:
        print(r['B'],r['ideal_minimum_new_rungs'],r['packed_90bit_root_reserve_bytes'])
    for c in comparisons:
        f=Fraction(c['ideal_rung_to_word_break_even'])
        print(c['B_low'],c['B_high'],'break-even interval:',f.numerator//f.denominator,ceildiv(f.numerator,f.denominator))
