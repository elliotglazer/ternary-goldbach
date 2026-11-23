"""Move cutovers while retaining the same dyadic grids, degrees and packet circuits."""
from fractions import Fraction as F
from functools import lru_cache
from math import isclose
from pathlib import Path
import json
import sys
from price_axes import HERE, HOL, AGENTS, read, pins
from price_source import geometry, price
from source_bounds import bounds as residual_bound, WIDTH

sys.path.insert(0,str(HOL/"coefficient-panels"))
from panel import bounds as translation_bound

def admissible(j, f, degree):
    a=residual_bound(j,f,20)
    b=translation_bound(f,j,degree)
    return a is not None and a[0]<F(1,2) and a[1]<WIDTH-2 and b is not None and b<F(1,1<<110)

def cutoff(f,degree,top):
    lo,hi=-1,top+1
    while hi-lo>1:
        j=(lo+hi)//2
        if admissible(j,f,degree):
            lo=j
        else:
            hi=j
    assert admissible(lo,f,degree) and (lo==top or not admissible(lo+1,f,degree))
    return lo

def main():
    wide=HOL/"wide-band-slab"
    hist=read(HERE/"guard.json")["scenarios"]["640"]
    caps=read(HOL/"large-weighted-slab/adaptive-groups.json")["maximum_bytes"]
    kernel=read(wide/"all-costs.json")["rows"]
    geom=read(wide/"geometry-costs.json")["bands"]
    coeff=read(wide/"coefficient-costs.json")["bands"]
    priced=read(HOL/"coefficient-panels/costs.json")["bands"]
    old=read(HOL/"large-weighted-slab/later-band-budget.json")["bands"]
    manifest=read(AGENTS/"integration/transform_structural_manifest_20261111.json")
    rows=sorted((c,phi,j+681) for c,phi,_,_,j,_,_ in manifest["conductors"])
    top=max(h for c,phi,h in rows)-1
    assert top==84880
    lo=0
    regions=[]
    for i,(saved,tab) in enumerate(zip(old,priced,strict=True)):
        grid=saved["cells"]-1
        deg=tab["degree"]
        j=cutoff(grid,deg,top)
        # Keep each transition at an original packet boundary, counted since index 1.
        hi=1+8*(j//8) if j<top else top+1
        assert hi>lo
        r=geometry(rows,lo,hi,grid+1,caps)
        root=price(r,kernel[i],geom[i],coeff[i])
        a=residual_bound(hi-1,grid,20)
        b=translation_bound(grid,hi-1,deg)
        assert b<F(1,1<<110) and a[0]<F(1,2)
        o_lo,o_hi=saved["height_indices"]
        factor=(hi-lo)/(o_hi-o_lo)
        regions.append(dict(band=i+1,start=lo,stop=hi,ceiling_exclusive_without_alignment=j+1,
                     grid=grid,seed_degree=deg,residue_charge_fraction=float(a[0]),
                     seed_error_relative_to_limit=float(b*(1<<110)),
                     seed_groups=grid//16*(hi-lo),seed_table_hours=factor*(tab["native_hours"]+tab["standalone_hol_hours"]),
                     **r,**root))
        lo=hi
        if lo==top+1: break
    assert lo==top+1 and len(regions)==5
    old_table=sum(r["native_hours"]+r["standalone_hol_hours"] for r in priced)+hist["added"]["coefficient_generation_and_checks"]
    old_src=hist["source_kernel"]+hist["source_inputs"]+old_table
    new_src=sum(r["kernel_hours"]+r["input_hours"]+r["seed_table_hours"] for r in regions)
    assert sum(r["units"] for r in regions)==sum(r["units"] for r in hist["bands"])
    old_seeds=sum(r["groups"]*(r["degree"]+1) for r in priced)+hist["additional_seed_groups"]*(priced[-1]["degree"]+1)
    new_seeds=sum(r["seed_groups"]*(r["seed_degree"]+1) for r in regions)
    res=dict(guard=640,regions=regions,old_source_hours=old_src,new_source_hours=new_src,
             saving_at_existing_rates=old_src-new_src,old_complex_seeds=old_seeds,
             new_complex_seeds=new_seeds,conditional_partial=[v+new_src-old_src for v in hist["partial"]],
             hashes=pins,scope="Applies existing per-band HOL and native prices at their new height allocation. Uniform rational bounds hold for ideal admitted seeds at 320 bits; cost rates at moved heights require measurement. Group endpoint certification remains outstanding.")
    (HERE/"adaptive.json").write_text(json.dumps(res,indent=2)+"\n")
    print([(r["start"],r["stop"],r["grid"],r["seed_degree"]) for r in regions])
    print(old_src,new_src,old_seeds,new_seeds,res["conditional_partial"])
if __name__=="__main__":
    main()
