"""Integer geometry and proposed proof-template counts only; no transforms or primes."""
from functools import lru_cache
from pathlib import Path
import json

def ceildiv(a,b): return (a+b-1)//b
def S(n): return 5*n*n+2*n+1
def A(n): return 2*n+1
@lru_cache(None)
def G(n):
    if n<=3: return S(n)
    h=ceildiv(n,2); g=n//2
    return min(S(n),G(h)+G(g)+G(h+1)+12*h+8*n+21)

rows=[]
for label,W,d,m,k in [
    ('hypothetical_full_halo',2**18,2**19,512,10),
    ('hypothetical_narrow_span',2**18,4096,512,10),
    ('historical_geometry_262144',262144,3789,188,9),
    ('historical_geometry_1048576',1048576,5056,250,9),
]:
    length=W+2*d; ell=(length-1).bit_length(); T=2**ell
    assert T>=length and m<=2**(k-1)
    bflies=T*ell//2
    nontriv=bflies-(T-1)
    muls=3*nontriv+T
    adds=3*T*ell
    nq=ceildiv(k*(W+d),8); na=ceildiv(k*(d+1),8)
    chunks=ceildiv(nq,na)
    rows.append(dict(label=label,W=W,d=d,m=m,k=k,coefficient_length=length,
        T=T,ell=ell,Q_bits=k*(W+d),A_bits=k*(d+1),product_bound_bits=k*length,
        butterfly_per_transform=bflies,unity_twiddles_per_transform=T-1,
        forward_accept_mod_muls=muls,forward_accept_mod_adds=adds,
        inverse_route_extra_scaling_muls=T,twiddle_setup_muls=max(0,T//2-1),
        twiddle_32bit_bytes=4*(T//2),two_buffers_32bit_bytes=8*T,
        all_three_stage_arrays_32bit_bytes=12*(ell+1)*T,
        C_kbit_bytes=ceildiv(k*length,8),
        modular_product_Q4=205,product_only_template_events=205*muls,
        dense_word_OR_updates=m*ceildiv(W,64),
        dense_source_bit_visits=m*W,
        byte_nq=nq,byte_na=na,byte_chunks=chunks,
        padded_Karatsuba_template=G(nq),
        chunked_Karatsuba_template=chunks*(G(na)+A(2*na)),
        rectangular_schoolbook_template=5*nq*na+2*min(nq,na)+1))

# Standard power-of-two DFT count identities only, not NTT arithmetic.
for ell in range(1,26):
    T=2**ell
    assert sum(T//(2**s) for s in range(1,ell+1))==T-1
    assert sum(T//2 for _ in range(ell))==T*ell//2
out=dict(scope='geometry and template-event sensitivity only; no prime/root/NTT values or timings',
    rows=rows,dyadic_schedule_count_checks=50,
    conditional_prime_bits=32,modular_add_and_representation_cost='not priced')
if __name__=='__main__':
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    for row in rows:
        print(row['label'],row['T'],row['forward_accept_mod_muls'],row['forward_accept_mod_adds'],
              row['product_only_template_events'],row['chunked_Karatsuba_template'])
