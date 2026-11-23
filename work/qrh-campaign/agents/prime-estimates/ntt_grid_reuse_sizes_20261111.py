"""Exact grid counts and symbolic NTT reuse costs; no arrays/primes/transforms."""
from fractions import Fraction
from pathlib import Path
import json
def cd(a,b): return (a+b-1)//b
W=2**18; D=2**19; T=2**21; ell=21
mu=T*ell//2-T+1; alpha=T*ell
rows=[]
for B in [10**16,2*10**16]:
    E=B//2
    for power in [32,34,36]:
        L=2**power; R=E//L; J=cd(L,W); wlast=E-R*L+1
        jlast=cd(wlast,W); cells=(R-1)*J+jlast
        assert (L-2)+(R-1)*L+wlast==E-1
        transforms=J+R+cells
        shared=transforms*mu+cells*T
        isolated=cells*(3*mu+T)
        assert isolated-shared==(2*cells-J-R)*mu
        schedules=[]
        for cap in [1,8,64,512]:
            # Tile-strip sweep retains cap source transforms; streams all rows.
            tile_source=J; tile_anchor=R*cd(J,cap)
            # Row-strip sweep retains cap anchor transforms; streams all tiles.
            row_source=J*cd(R,cap); row_anchor=R
            schedules.append(dict(cap=cap,retained_raw_bytes=4*T*cap,
                tile_strip_source_transforms=tile_source,tile_strip_anchor_transforms=tile_anchor,
                row_strip_source_transforms=row_source,row_strip_anchor_transforms=row_anchor,
                tile_strip_upper_muls=(tile_source+tile_anchor+cells)*mu+cells*T,
                row_strip_upper_muls=(row_source+row_anchor+cells)*mu+cells*T))
        rows.append(dict(B=B,L=L,R=R,J=J,last_width=wlast,last_tiles=jlast,cells=cells,
            source_cache_raw_bytes=4*T*J,anchor_cache_raw_bytes=4*T*R,
            shared_transforms=transforms,isolated_transforms=3*cells,
            shared_mod_muls=shared,isolated_mod_muls=isolated,
            mul_ratio=str(Fraction(shared,isolated)),
            shared_mod_adds=transforms*alpha,isolated_mod_adds=3*cells*alpha,
            logical_cached_operand_residues_read=2*T*cells,
            both_operands_uncached_read_bytes=8*T*cells,schedules=schedules))
out=dict(scope='grid metadata and proof-template arithmetic only',W=W,D=D,T=T,ell=ell,
    one_transform_nonunity_products=mu,one_transform_mod_adds=alpha,
    isolated_products_per_cell=3*mu+T,shared_limit_products_per_cell=mu+T,
    asymptotic_product_ratio=str(Fraction(mu+T,3*mu+T)),
    narrow_span_isolated_products=3*(2**19*19//2-2**19+1)+2**19,rows=rows)
if __name__=='__main__':
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    for r in rows:
        print(r['B'],r['L'],r['R'],r['J'],r['cells'],r['last_width'],
              float(Fraction(r['mul_ratio'])),r['source_cache_raw_bytes'],r['anchor_cache_raw_bytes'])
