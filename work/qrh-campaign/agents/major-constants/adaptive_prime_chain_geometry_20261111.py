"""Integer coverage/encoding and symbolic operation counts. No primality tests."""
from fractions import Fraction
from pathlib import Path
import json

def ceildiv(a,b):
    assert b>0
    return -(-a//b)

N=10**27
T=N-1
F=2**45
assert F*F>N and N<2**90
rows=[]
for B,W,S in [(10**16,128,157),(2*10**16,256,313),(4*10**18,2048,111616)]:
    H,R=divmod(B-2,F)
    target_k=ceildiv(T-B-1,F)
    first_k_max=B//F
    all_prime_lower=max(0,ceildiv(T-B-3,B-2))
    same_F_lower=1+max(0,ceildiv(target_k-first_k_max,H))
    assert S+W-1<=H and S>=W
    conditional=[]
    for dmax in sorted({0,min(16,H-1),min(64,H-1),W-1}):
        G=H-dmax
        bound=1+max(0,ceildiv(target_k-1,G))
        assert (bound-1)*G+1>=target_k
        conditional.append(dict(deficit_max=dmax,min_k_jump=G,
            record_count_upper_if_success=bound))
    old_window_count=(N-5)//(S*F)
    rows.append(dict(B=B,F=F,H=H,lattice_remainder=R,
        deficit_width=(H-1).bit_length(),old_offset_width=(W-1).bit_length(),
        target_k=target_k,first_k_max=first_k_max,
        necessary_new_primes_all_formats=all_prime_lower,
        necessary_same_F_records=same_F_lower,
        old_fixed_window_count=old_window_count,
        best_stride_ratio=f'{H}/{S}',conditional_bounds=conditional))

batches=[]
for n in [1,8,16,32,64,128]:
    # Dense worst-case 90-bit factors, not actual candidates or measured sizes.
    batches.append(dict(factors=n,product_bit_bound=90*n,
        product_multiplications=n-1,common_root_squares=44,
        direct_root_squares=44*n,root_payload_bit_upper=90*n,
        schoolbook_square_work_ratio_common_to_direct=n,
        generic_direct_k_batch_squares_upper=88))

# Encoding identity for symbolic previous odd endpoint and each dictionary F.
# These are small integer boundary examples, not prime candidates/tests.
examples=[]
for prev,B,f in [(3,100,16),(51,100,16),(99,100,24),(3,100,200)]:
    q=(prev+B-3)//f
    low=(prev-1)//f+1
    count=max(0,q-low+1)
    if count:
        for d in [0,count-1]:
            k=q-d
            nxt=k*f+1
            assert prev<nxt<=prev+B-2
            assert nxt+4<=prev+B+2
    examples.append(dict(previous=prev,B=B,F=f,upper_k=q,lower_k=low,count=count))

out=dict(scope='exact geometry and conditional operation counts only; no prime data',
    N=N,T=T,rows=rows,batches=batches,encoding_boundary_examples=examples,
    certificates_produced=0)
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,indent=2))
