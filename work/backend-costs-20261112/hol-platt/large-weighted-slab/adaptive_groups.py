"""Regroup active conductors by band under the same packed-output memory ceiling."""
import hashlib
import json
from pathlib import Path
from statistics import median

from schedule import PATH

HERE=Path(__file__).resolve().parent


def groups(rows, cap, maximum):
    current=[]
    size=0
    for row in rows:
        need=8*30*row[1]
        if current and (size+need>cap or len(current)>=maximum):
            yield current,size
            current,size=[],0
        assert need<=cap
        current.append(row)
        size+=need
    if current:
        yield current,size


def main():
    data=PATH.read_bytes()
    rows=sorted((c,phi,j+41) for c,phi,_,_,j,_,_ in json.loads(data)['conductors'])
    prior=json.loads((HERE/'schedule.json').read_bytes())
    base=next(r for r in prior['schedules'] if r['conductors_per_group']==32 and r['heights_per_block']==8)
    cap=base['max_raw_bytes_for_one_eight_or_32_height_residue_buffer']
    budget=json.loads((HERE/'later-band-budget.json').read_bytes())
    occupancy=json.loads((HERE/'occupied-cells.json').read_bytes())
    assert prior['manifest_sha256']==hashlib.sha256(data).hexdigest()==budget['manifest_sha256']==occupancy['manifest_sha256']
    fixed=[r['reference_control_seconds'] for r in budget['thresholds']]
    old=sum(b['occupied'] for b in occupancy['bands'])
    scenarios={}
    for maximum in (32,64,128,256,512):
        bands=[]
        for b in budget['bands']:
            lo,hi=b['height_indices']
            active=[(c,phi,(min(hi,j)-lo+7)//8) for c,phi,j in rows if j>lo]
            packed=list(groups(active,cap,maximum))
            assert [r for p,size in packed for r in p]==active and all(size<=cap for p,size in packed)
            calls=b['cells']*sum(max(v for c,phi,v in part) for part,size in packed)
            bands.append(dict(lo=lo,groups=len(packed),calls_even_if_empty=calls,
                              group_sizes=[min(len(p) for p,s in packed),median(len(p) for p,s in packed),
                                           max(len(p) for p,s in packed)],max_raw_buffer=max(s for p,s in packed)))
        calls=sum(b['calls_even_if_empty'] for b in bands)
        scenarios[maximum]=dict(bands=bands,calls_all_bands=calls,
                                avoided_calls_against_old_exact_occupancy=old-calls,
                                hours_saved_if_fixed_rates_transfer=[(old-calls)*t/3600 for t in fixed])
    result=dict(heights=8,maximum_bytes=cap,original_occupied_calls=old,
                manifest_sha256=prior['manifest_sha256'],scenarios=scenarios)
    (HERE/'adaptive-groups.json').write_text(json.dumps(result,indent=2)+'\n')
    for k,s in scenarios.items():
        print(k,s['calls_all_bands'],s['hours_saved_if_fixed_rates_transfer'])


if __name__=='__main__':
    main()
