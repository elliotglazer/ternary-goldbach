"""Exact geometry and source hashes only. No primality/function evaluation."""
from pathlib import Path
from fractions import Fraction
import hashlib, json

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
T=989*10**24
O=T-1
F=2**45
D=2**19
BS=[10**15,2*10**15,5*10**15,10**16,2*10**16,5*10**16,10**17,5*10**17,10**18,4*10**18]
LS=[2**32,2**34,2**36]
def ceildiv(a,b): return -(-a//b)
def rat(x): return {'numerator':str(x.numerator),'denominator':str(x.denominator)}
def depth(b,u):
    k=0
    while u*2**k<b: k+=1
    return k
def kmax(b):
    k=0; fact=1
    while fact*(k+2)<=b:
        k+=1;fact*=k+1
    return k

rows=[]
for B in BS:
    E=B//2;H=(B-2)//F;rem=B-2-H*F
    kt=ceildiv(O-B-1,F);first=B//F
    lo=max(0,ceildiv(O-B-3,B-2))
    lattice_lo=1+max(0,ceildiv(kt-first,H))
    # The three integer gate values stay fixed in this closed integer cell.
    left=max(H*F+2,first*F,O-1-kt*F)
    right=min((H+1)*F+1,(first+1)*F-1,O-2-(kt-1)*F)
    evenleft=2*ceildiv(left,2);evenright=2*(right//2)
    assert evenleft<=B<=evenright
    for b in [evenleft,evenright]:
        assert ((b-2)//F,b//F,ceildiv(O-b-1,F))==(H,first,kt)
    item={'B':str(B),'anchor_max':str(B-1),'anchor_bits':(B-1).bit_length(),
      'H':H,'gap_remainder':rem,'deficit_bits':(H-1).bit_length(),
      'all_format_necessary_new_primes':str(lo),'same_F_necessary_new_primes':str(lattice_lo),
      'same_F_gate_cell_even':[str(evenleft),str(evenright)],
      'conditional_dmax0_upper':str(1+max(0,ceildiv(kt-1,H))),
      'conditional_dmax16_upper':str(1+max(0,ceildiv(kt-1,H-16))),
      'blocks':[]}
    assert H>16
    for L in LS:
        U=2*(L+D)-1;R=E//L;last=E-R*L+1
        assert U*U>B
        assert (L-2)+(R-1)*L+last==E-1
        item['blocks'].append({'L':str(L),'source_U':str(U),'R':str(R),
          'last_width':str(last),'outer_targets':str(E-L+1),
          'source_bits':str(L+D),'source_raw_bytes':str(ceildiv(L+D,8)),
          'conditional_chain_edges_upper':depth(B-1,U),
          'coarse_component_power_products':2*((B-2).bit_length()-1),
          'factor_count_factorial_upper':kmax(B-2)})
    rows.append(item)
switches=[]
for b0,b1 in zip(BS,BS[1:]):
    switches.append({'B_small':str(b0),'B_large':str(b1),
      'c_over_a_threshold_when_kappa1':rat(Fraction(b0*b1,T))})
pins={}
for rel in ['major-constants/EFFICIENCY_ADAPTIVE_PRIME_CHAIN_2026-11-11.md',
 'moebius/EFFICIENCY_BINARY_DIRECT_ORDER_CERTIFICATES_2026-11-11.md',
 'audit/REVIEW_EFFICIENCY_BINARY_DIRECT_ORDER_CERTIFICATES_2026-11-11.md',
 'moebius/EFFICIENCY_BINARY_COVERAGE_2026-11-11.md',
 'moebius/EFFICIENCY_JOINT_BINARY_FRONTIER_2026-11-11.md']:
    pins[rel]=hashlib.sha256((AGENTS/rel).read_bytes()).hexdigest().upper()
out={'scope':'integer geometry only; no primality, analytic, build, or runtime claim',
 'T_even_threshold':str(T),'last_odd':str(O),'F':str(F),'D':D,
 'rows':rows,'illustrative_switches':switches,'pins':pins}
target=HERE/'binary_adaptive_joint_metadata_20261111.json'
target.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
for r in rows:
    print(r['B'],r['anchor_bits'],r['H'],r['all_format_necessary_new_primes'],
          r['same_F_necessary_new_primes'],[x['R'] for x in r['blocks']],
          [x['conditional_chain_edges_upper'] for x in r['blocks']])
print('saved',target.name)
