"""Exact binary-anchor geometry and certificate-size bounds; no primality calls."""
from pathlib import Path
import json
from math import isqrt

A=512
D0=2**19
T=2**18
rows=[]
for B in (10**16,2*10**16):
    m=1
    while 2**(2*m)<=B:
        m+=1
    F=2**m
    g=F//2
    Ds=A*g-1
    strict_D=(2*A-1)*g-1
    b=(B-1).bit_length()
    for ell in (32,34,36):
        L=2**ell
        R=(B//2)//L
        J=L+D0
        U=2*J-1
        h=0
        while (2**h)*U<B:
            h+=1
        old_capacity=(D0+1)//g
        r_first=(A*g)//L+1
        assert F*F>B and (F//2)**2<=B
        assert L%g==0 and old_capacity==0
        assert (L-2)+(R-1)*L+(B//2-R*L+1)==B//2-1
        assert 2*r_first*L-2*A*g+1>=3
        if r_first>1:
            assert 2*(r_first-1)*L-2*A*g+1<3
        Rmax=(B-2)//(U+1)
        assert U*U>B
        rows.append(dict(B=B,L_power=ell,blocks=R,nominal_anchors=A*R,
            anchor_bits=b,source_limit=U,source_bytes=(J+7)//8,
            above_source_chain_nodes_upper=h,
            large_factor_second_exponent_upper=Rmax,
            large_factor_second_exponent_bits=Rmax.bit_length(),
            one_large_factor_modular_product_upper=2*b+Rmax.bit_length(),
            proth_m=m,lattice_step=F,index_step=g,
            old_halo_lattice_candidates=old_capacity,
            halo_for_512_lattice_candidates=Ds,
            halo_for_512_strict_odd_k_candidates=strict_D,
            first_origin_block_with_512_positive_lattice_candidates=r_first,
            enlarged_source_bytes=(L+Ds+7)//8,
            enlarged_source_limit=2*(L+Ds)-1,
            enlarged_base_limit=isqrt(2*(L+Ds)-1),
            max_blocks_reusing_one_structured_anchor=Ds//L+1,
            nominal_above_source_chain_nodes_upper=A*R*h,
            aligned_tile_source_chunks=(T+Ds+T-1)//T,
            consecutive_candidate_span=(A-1)*g,
            span_normalized_tile_chunks=(T+(A-1)*g+T-1)//T,
            residue_rows=g,targets_per_residue_full_block=L//g,
            proth_single_exponent_modular_product_upper=2*b-3))

result=dict(scope="integer geometry only; lattice candidates are not certified primes",A=A,
    old_D=D0,source_chunk_bits=T,rows=rows)
if __name__=='__main__':
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    for r in rows:
        print(r)
