"""Rebuild the large-source geometry at each guard and join disjoint cost changes."""
from math import isclose
from pathlib import Path
from statistics import median
import sys
import json

from price_axes import AGENTS, HERE, HOL, EXTRAS, read, pins
sys.path.insert(0, str(HOL/"wide-band-slab"))
from tile_schedule import geometry_loads, groups

def geometry(rows, lo, hi, cells, cap):
    active=[]
    actual=padded=0
    for c,phi,h in rows:
        u=max(0,min(hi,h)-lo)
        if u:
            n=(u+7)//8
            active.append((c,phi,n))
            actual+=u*phi
            padded+=8*n*phi
    batch=list(groups(active,cap,128))
    calls=geoms=loads=peak=0
    for i in range(0,len(batch),4):
        tile=batch[i:i+4]
        ends=[]
        for gp,size in tile:
            stops=[n for c,phi,n in gp]
            ends.append(max(stops))
            calls+=cells*ends[-1]
            geoms+=cells*geometry_loads(stops,4)
        loads+=cells*max(ends)
        peak=max(peak,sum(size for gp,size in tile)*min(4,max(ends)))
    return dict(units=actual,padded=padded,calls=calls,geometry_loads=geoms,coefficient_loads=loads,peak_bytes=peak)

def price(row, fixed, geo, literal):
    count=row["calls"]
    g=row["geometry_loads"]
    r=row["coefficient_loads"]
    kernel=count*fixed["fixed_cpu"]/3600+row["padded"]*median(fixed["paired_marginal_us"])/3.6e9
    cold=geo["first_setup_seconds"]
    warm=geo["warm_setup_seconds"]
    setup=(g*cold+(count-g)*warm)/3600
    geo_load=g*geo["literal_geometry_read_hours"]/geo["geometry_epochs"]
    coef=count*literal["original_literal_seconds"]/3600-(count-r)*literal["credited_seconds"]/3600
    return dict(kernel_hours=kernel,input_hours=setup+geo_load+coef,
                statement_setup=setup,geometry_input=geo_load,coefficient_input=coef)

def main():
    slab=HOL/"large-weighted-slab"
    wide=HOL/"wide-band-slab"
    frozen=read(slab/"later-band-budget.json")["bands"]
    cap=read(slab/"adaptive-groups.json")["maximum_bytes"]
    kernel=read(wide/"all-costs.json")
    geom=read(wide/"geometry-costs.json")["bands"]
    coeff=read(wide/"coefficient-costs.json")
    old_tiles=read(wide/"tile-schedule.json")["4x4"]["bands"]
    tab=read(HOL/"coefficient-panels/costs.json")
    manifest=read(AGENTS/"integration/transform_structural_manifest_20261111.json")
    prefix=read(HOL/"small-gaussian/costs.json")["new_partial_hours"]
    thin=read(HOL/"sparse-head/results.json")
    census=read(HERE/"axes.json")["extras"]
    layouts=read(HOL/"campaign-cost-ledger/ledger.json")["rows"]
    hmax=max(r[4]+41 for r in manifest["conductors"])
    assert hmax==frozen[-1]["height_indices"][1]
    coefper=tab["bands"][-1]
    groups_per_height=(frozen[-1]["cells"]-1)//16
    lo,hi=frozen[-1]["height_indices"]
    assert coefper["groups"]==groups_per_height*(hi-lo)
    out={}
    for e,layout in zip(EXTRAS,layouts,strict=True):
        assert e==layout["extra"]
        rows=sorted((c,phi,j+41+e) for c,phi,_,_,j,_,_ in manifest["conductors"])
        zones=[(*z["height_indices"],z["cells"]) for z in frozen]
        if e:
            zones.append((hmax,hmax+e,frozen[-1]["cells"]))
        bands=[]
        for i,(lo,hi,cells) in enumerate(zones):
            t=min(i,len(frozen)-1)
            r=geometry(rows,lo,hi,cells,cap)
            hr=price(r,kernel["rows"][t],geom[t],coeff["bands"][t])
            if not e:
                assert (r["units"], r["padded"])==(frozen[t]["units"], frozen[t]["units"]+frozen[t]["pad"])
                ref=old_tiles[t]
                assert all(r[k]==ref[k] for k in ("calls","geometry_loads","coefficient_loads"))
            bands.append(dict(lo=lo,hi=hi,cells=cells,**r,**hr))
        assert [b["units"] for b in bands] == census[str(e)]["source_inputs_by_band"][:len(bands)]
        source=sum(b["kernel_hours"] for b in bands)
        prep=sum(b["input_hours"] for b in bands)
        if not e:
            assert isclose(source,kernel["source_kernel_hours"],rel_tol=1e-12)
            assert isclose(prep,coeff["tiles"]["4x4"]["preparation_hours"],rel_tol=1e-12)
        times=census[str(e)]
        more=dict(long_transform=times["added_long"],short_transform=times["added_short"],
                  source_kernel=source-(out[0]["source_kernel"] if e else source),
                  source_inputs=prep-(out[0]["source_inputs"] if e else prep),
                  coefficient_generation_and_checks=e*groups_per_height*(coefper["native_hours"]+
                      coefper["standalone_hol_hours"])/coefper["groups"])
        delta=sum(more.values())
        sparse=layout["modeled_sample_population"]*thin["explicit_inner_seconds"]/(340484*3600)
        partial=[v+sparse+delta for v in prefix]
        out[e]=dict(bands=bands,source_kernel=source,source_inputs=prep,added=more,
                    added_total=delta,small_sparse_observations=sparse,partial=partial,
                    remaining_to_800k=[800000-v for v in reversed(partial)],
                    additional_seed_groups=e*groups_per_height,
                    extra_source_interval=[hmax,hmax+e],extra_source_interval_hours=
                    (bands[-1]["kernel_hours"]+bands[-1]["input_hours"] if e else 0))
    result=dict(scenarios=out,hashes=pins,
        scope="Reprices the large-axis transforms, packed Hurwitz sources and grouped coefficient work in the same 4x4 tile scenario. A fresh interval above the old ceiling uses the fifth band's cell spacing, degree and unit prices, subject to analytic verification. Small-family upstream guard increments, seed proofs, character gathering, signs, all retries, principal and proof transport are not included in the added_large amounts.")
    (HERE/"guard.json").write_text(json.dumps(result,indent=2)+"\n")
    for e,r in out.items():
        print(e,{k:round(v) for k,v in r["added"].items()},[round(x) for x in r["partial"]])
if __name__=="__main__":
    main()
