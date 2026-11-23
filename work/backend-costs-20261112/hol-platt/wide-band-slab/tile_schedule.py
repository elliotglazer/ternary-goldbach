"""Bound output buffering and count exactly how often each input is needed in a two-dimensional tile."""
import json
import sys
from pathlib import Path

HERE=Path(__file__).resolve().parent
SLAB=HERE.parent/'large-weighted-slab'
sys.path.insert(0,str(SLAB))
from adaptive_groups import groups
from schedule import PATH


def read(p):
    return json.loads(p.read_bytes())


def geometry_loads(stops,blocks):
    horizons=sorted(set(stops))
    count=(horizons[-1]+blocks-1)//blocks
    return count+sum(h%blocks!=0 for h in horizons[:-1])


def main():
    assert geometry_loads([2,4,4,7,13],4)==len({1,3,5,8,9,13})
    conductors=sorted((c,phi,j+41) for c,phi,_,_,j,_,_ in read(PATH)['conductors'])
    plan=read(SLAB/'adaptive-groups.json')
    zones=read(SLAB/'later-band-budget.json')['bands']
    geometry=read(HERE/'geometry-costs.json')['bands']
    panels=read(HERE/'all-costs.json')
    cases={}
    for tile,blocks in ((1,1),(1,4),(2,4),(4,2),(8,1),(4,4),(8,4),(16,4)):
        estimates=[]
        for z,price in zip(zones,geometry,strict=True):
            lo,hi=z['height_indices']
            active=[(c,phi,(min(hi,j)-lo+7)//8) for c,phi,j in conductors if j>lo]
            pack=list(groups(active,plan['maximum_bytes'],128))
            calls=reads=geoms=peak=max_residues=0
            cells=z['cells']
            for i in range(0,len(pack),tile):
                batch=pack[i:i+tile]
                heights=[]
                residues=0
                for gp,size in batch:
                    stops=[n for c,phi,n in gp]
                    m=max(stops)
                    heights.append(m)
                    calls+=cells*m
                    geoms+=cells*geometry_loads(stops,blocks)
                    residues+=sum((c+cells-2)//(cells-1) for c,phi,n in gp)
                reads+=cells*max(heights)
                max_residues=max(max_residues,residues)
                peak=max(peak,sum(size for gp,size in batch)*min(blocks,max(heights)))
            assert calls==price['calls'] and reads<=calls and geoms<=calls
            warm=price['warm_setup_seconds']; first=price['first_setup_seconds']
            setup=((calls-geoms)*warm+geoms*first)/3600
            loads=price['literal_geometry_read_hours']*geoms/price['geometry_epochs']
            base=price['literal_coefficient_read_hours']
            estimates.append(dict(band=price['band'],calls=calls,geometry_loads=geoms,coefficient_loads=reads,
                output_buffer_bytes=peak,geometry_rows_per_anchor_at_most=max_residues,
                preparation_hours=setup,literal_geometry_hours=loads,
                coefficient_hours_if_all_literal_load_is_shared=base*reads/calls,
                coefficient_hours_if_no_literal_load_is_shared=base))
        totals=[sum(r['preparation_hours']+r['literal_geometry_hours']+r[col] for r in estimates)
                for col in ('coefficient_hours_if_all_literal_load_is_shared','coefficient_hours_if_no_literal_load_is_shared')]
        cases[f'{tile}x{blocks}']=dict(groups_per_tile=tile,eight_height_blocks_per_tile=blocks,bands=estimates,
            max_output_buffer_bytes=max(r['output_buffer_bytes'] for r in estimates),
            max_geometry_rows_per_anchor=max(r['geometry_rows_per_anchor_at_most'] for r in estimates),
            preparation_hours_by_coefficient_sharing=totals,
            partial_24h_by_sharing=[[h+t for h in panels['other_components_and_source']['24']['partial_kernel_scenario']] for t in totals])
    (HERE/'tile-schedule.json').write_text(json.dumps(cases,indent=2)+'\n')
    for key,row in cases.items():
        print(key,row['max_output_buffer_bytes'],row['preparation_hours_by_coefficient_sharing'])


if __name__=='__main__':
    main()
